from pymongo import MongoClient
from bson.objectid import ObjectId
from robot.api.deco import keyword
import json
import logging
from collections.abc import MutableMapping

# Set up logging
logging.basicConfig(level=logging.INFO, 
                   format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class MongoDBLibrary:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    def __init__(self):
        self.client = None
        self.db = None
        logger.info("MongoDBLibrary initialized")

    def _convert_id(self, doc_id):
        """Helper method to convert ID to appropriate type for MongoDB query."""
        logger.debug(f"Converting ID: {doc_id} (type: {type(doc_id)})")
        
        # Handle case where doc_id is a string that looks like a dictionary
        if isinstance(doc_id, str) and doc_id.startswith('{') and doc_id.endswith('}'):
            try:
                import ast
                doc_id = ast.literal_eval(doc_id)
                logger.debug(f"Converted string to dict: {doc_id}")
            except (ValueError, SyntaxError) as e:
                logger.debug(f"Could not convert string to dict: {e}")
        
        # Handle case where doc_id is a dictionary with '_id' key
        if isinstance(doc_id, dict) and '_id' in doc_id:
            logger.debug(f"Extracting _id from dictionary: {doc_id}")
            doc_id = doc_id['_id']
            logger.debug(f"Extracted _id value: {doc_id} (type: {type(doc_id)})")
        
        # If it's already the correct type, return as-is
        if isinstance(doc_id, (ObjectId, int)):
            logger.debug(f"ID is already correct type: {type(doc_id)}")
            return doc_id
            
        # If it's a string, try to convert to ObjectId or int
        if isinstance(doc_id, str):
            # Try ObjectId if it looks like one
            if len(doc_id) == 24:
                try:
                    obj_id = ObjectId(doc_id)
                    logger.debug(f"Converted to ObjectId: {obj_id}")
                    return obj_id
                except Exception as e:
                    logger.debug(f"Not a valid ObjectId: {str(e)}")
            
            # Try converting to int if it's a numeric string
            if doc_id.isdigit():
                try:
                    int_id = int(doc_id)
                    logger.debug(f"Converted to int: {int_id}")
                    return int_id
                except Exception as e:
                    logger.debug(f"Could not convert to int: {str(e)}")
        
        logger.debug(f"Using ID as-is: {doc_id}")
        return doc_id

    def _handle_mongodb_error(self, operation, collection, error, doc_id=None):
        """Helper method to handle MongoDB errors consistently without failing tests."""
        error_info = {
            'operation': operation,
            'collection': collection,
            'error': str(error)
        }
        
        if doc_id is not None:
            error_info['document_id'] = doc_id
            
        # Handle specific MongoDB error codes
        if hasattr(error, 'details'):
            error_info['details'] = error.details
            
        # Handle validation errors (code 121)
        if hasattr(error, 'code') and error.code == 121:
            if hasattr(error, 'details'):
                error_info['validation_errors'] = error.details.get('errInfo', {}).get('details', {})
            logger.error(f"Validation error in {operation}: {error_info}")
            # On retourne None au lieu de lever une exception
            return None
            
        # Handle duplicate key errors (code 11000)
        elif hasattr(error, 'code') and error.code == 11000:
            logger.error(f"Duplicate key error in {operation}: {error_info}")
            # On retourne None au lieu de lever une exception
            return None
            
        # Handle other MongoDB errors
        else:
            logger.error(f"MongoDB error in {operation}: {error_info}")
            # On retourne None pour les autres erreurs aussi
            return None

    @keyword('Connect To MongoDB')
    def connect(self, uri, db_name):
        """Connect to MongoDB with the given URI and database name."""
        logger.info(f"Connecting to MongoDB: {uri}")
        try:
            self.client = MongoClient(uri)
            self.db = self.client[db_name]
            # Test the connection
            self.client.server_info()
            logger.info(f"Successfully connected to database: {db_name}")
            return True
        except Exception as e:
            logger.error(f"Failed to connect to MongoDB: {str(e)}")
            raise

    @keyword('Disconnect From MongoDB')
    def disconnect(self):
        """Disconnect from MongoDB."""
        if self.client:
            logger.info("Disconnecting from MongoDB")
            self.client.close()
            self.client = None
            self.db = None
        return True

    # Products
    @keyword('Create Product')
    def create_product(self, product_data):
        """Create a new product in the database. Returns None on failure."""
        logger.info("Creating new product")
        logger.debug(f"Product data: {product_data}")
        
        if not isinstance(product_data, MutableMapping):
            logger.error("Product data must be a dictionary")
            return None
            
        try:
            product_data = dict(product_data)
            result = self.db.products.insert_one(product_data)
            product_id = str(result.inserted_id)
            logger.info(f"Product created successfully with ID: {product_id}")
            return product_id
        except Exception as e:
            return self._handle_mongodb_error('create_product', 'products', e)

    @keyword('Get Product')
    def get_product(self, product_id):
        """Retrieve a product by ID."""
        logger.info(f"Retrieving product with ID: {product_id}")
        
        try:
            converted_id = self._convert_id(product_id)
            logger.debug(f"Converted ID: {converted_id} (type: {type(converted_id)})")
            
            product = self.db.products.find_one({"_id": converted_id})
            
            if product:
                logger.debug(f"Found product: {product}")
                return json.loads(json.dumps(product, default=str))
            else:
                logger.warning(f"No product found with ID: {product_id}")
                return None
                
        except Exception as e:
            logger.error(f"Error retrieving product {product_id}: {str(e)}")
            return None

    @keyword('Update Product')
    def update_product(self, product_id, update_data):
        """Update a product with new data. Returns 0 on failure."""
        logger.info(f"Updating product with ID: {product_id}")
        logger.debug(f"Update data: {update_data}")
        
        try:
            update_data = dict(update_data)
            
            if '_id' in update_data:
                logger.debug("Removing _id from update data as it's immutable")
                del update_data['_id']
                
            if not update_data:
                logger.warning("No fields to update after removing _id")
                return 0
                
            converted_id = self._convert_id(product_id)
            result = self.db.products.update_one(
                {"_id": converted_id},
                {"$set": update_data}
            )
            
            if result.matched_count == 0:
                logger.warning(f"No product found with ID: {product_id}")
                return 0
                
            logger.info(f"Successfully updated {result.modified_count} product(s)")
            return result.modified_count
            
        except Exception as e:
            return self._handle_mongodb_error('update_product', 'products', e, product_id) or 0

    @keyword('Delete Product')
    def delete_product(self, product_id):
        """Delete a product by ID."""
        logger.info(f"Deleting product with ID: {product_id}")
        
        try:
            converted_id = self._convert_id(product_id)
            result = self.db.products.delete_one({"_id": converted_id})
            
            if result.deleted_count == 0:
                logger.warning(f"No product found with ID: {product_id}")
            else:
                logger.info(f"Successfully deleted {result.deleted_count} product(s)")
                
            return result.deleted_count
            
        except Exception as e:
            logger.error(f"Error deleting product {product_id}: {str(e)}")
            return 0

    # Users
    @keyword('Create User')
    def create_user(self, user_data):
        """Create a new user in the database."""
        logger.info("Creating new user")
        logger.debug(f"User data: {user_data}")
        
        if not isinstance(user_data, MutableMapping):
            error_msg = "User data must be a dictionary"
            logger.error(error_msg)
            raise ValueError(error_msg)
            
        try:
            user_data = dict(user_data)
            
            if '_id' not in user_data:
                logger.debug("No _id provided, MongoDB will generate one")
            
            result = self.db.users.insert_one(user_data)
            user_id = str(result.inserted_id)
            logger.info(f"User created successfully with ID: {user_id}")
            return user_id
            
        except Exception as e:
            self._handle_mongodb_error('create_user', 'users', e)

    @keyword('Get User')
    def get_user(self, user_id):
        """Retrieve a user by ID."""
        logger.info(f"Retrieving user with ID: {user_id}")
        
        try:
            converted_id = self._convert_id(user_id)
            user = self.db.users.find_one({"_id": converted_id})
            
            if user:
                logger.debug(f"Found user: {user}")
                return json.loads(json.dumps(user, default=str))
            else:
                logger.warning(f"No user found with ID: {user_id}")
                return None
                
        except Exception as e:
            logger.error(f"Error retrieving user {user_id}: {str(e)}")
            return None

    @keyword('Update User')
    def update_user(self, user_id, update_data):
        """Update a user with new data."""
        logger.info(f"Updating user with ID: {user_id}")
        logger.debug(f"Update data: {update_data}")
        
        try:
            update_data = dict(update_data)
            
            if '_id' in update_data:
                logger.debug("Removing _id from update data as it's immutable")
                del update_data['_id']
                
            if not update_data:
                logger.warning("No fields to update after removing _id")
                return 0
                
            converted_id = self._convert_id(user_id)
            result = self.db.users.update_one(
                {"_id": converted_id},
                {"$set": update_data}
            )
            
            if result.matched_count == 0:
                logger.warning(f"No user found with ID: {user_id}")
            else:
                logger.info(f"Successfully updated {result.modified_count} user(s)")
                
            return result.modified_count
            
        except Exception as e:
            self._handle_mongodb_error('update_user', 'users', e, user_id)

    @keyword('Delete User')
    def delete_user(self, user_id):
        """Delete a user by ID."""
        logger.info(f"Deleting user with ID: {user_id}")
        
        try:
            converted_id = self._convert_id(user_id)
            result = self.db.users.delete_one({"_id": converted_id})
            
            if result.deleted_count == 0:
                logger.warning(f"No user found with ID: {user_id}")
            else:
                logger.info(f"Successfully deleted {result.deleted_count} user(s)")
                
            return result.deleted_count
            
        except Exception as e:
            logger.error(f"Error deleting user {user_id}: {str(e)}")
            return 0

    # Carts
    @keyword('Create Cart')
    def create_cart(self, cart_data):
        """Create a new cart in the database."""
        logger.info("Creating new cart")
        logger.debug(f"Cart data: {cart_data}")
        
        if not isinstance(cart_data, MutableMapping):
            error_msg = "Cart data must be a dictionary"
            logger.error(error_msg)
            raise ValueError(error_msg)
            
        try:
            cart_data = dict(cart_data)
            
            if '_id' not in cart_data:
                logger.debug("No _id provided, MongoDB will generate one")
            
            result = self.db.carts.insert_one(cart_data)
            cart_id = str(result.inserted_id)
            logger.info(f"Cart created successfully with ID: {cart_id}")
            return cart_id
            
        except Exception as e:
            self._handle_mongodb_error('create_cart', 'carts', e)

    @keyword('Get Cart')
    def get_cart(self, cart_id):
        """Retrieve a cart by ID."""
        logger.info(f"Retrieving cart with ID: {cart_id}")
        
        try:
            converted_id = self._convert_id(cart_id)
            cart = self.db.carts.find_one({"_id": converted_id})
            
            if cart:
                logger.debug(f"Found cart: {cart}")
                return json.loads(json.dumps(cart, default=str))
            else:
                logger.warning(f"No cart found with ID: {cart_id}")
                return None
                
        except Exception as e:
            logger.error(f"Error retrieving cart {cart_id}: {str(e)}")
            return None

    @keyword('Update Cart')
    def update_cart(self, cart_id, update_data):
        """Update a cart with new data."""
        logger.info(f"Updating cart with ID: {cart_id}")
        logger.debug(f"Update data: {update_data}")
        
        try:
            update_data = dict(update_data)
            
            if '_id' in update_data:
                logger.debug("Removing _id from update data as it's immutable")
                del update_data['_id']
                
            if not update_data:
                logger.warning("No fields to update after removing _id")
                return 0
                
            converted_id = self._convert_id(cart_id)
            result = self.db.carts.update_one(
                {"_id": converted_id},
                {"$set": update_data}
            )
            
            if result.matched_count == 0:
                logger.warning(f"No cart found with ID: {cart_id}")
            else:
                logger.info(f"Successfully updated {result.modified_count} cart(s)")
                
            return result.modified_count
            
        except Exception as e:
            self._handle_mongodb_error('update_cart', 'carts', e, cart_id)

    @keyword('Delete Cart')
    def delete_cart(self, cart_id):
        """Delete a cart by ID."""
        logger.info(f"Deleting cart with ID: {cart_id}")
        
        try:
            converted_id = self._convert_id(cart_id)
            result = self.db.carts.delete_one({"_id": converted_id})
            
            if result.deleted_count == 0:
                logger.warning(f"No cart found with ID: {cart_id}")
            else:
                logger.info(f"Successfully deleted {result.deleted_count} cart(s)")
                
            return result.deleted_count
            
        except Exception as e:
            logger.error(f"Error deleting cart {cart_id}: {str(e)}")
            return 0

    # Categories
    @keyword('Create Category')
    def create_category(self, category_data):
        """Create a new category in the database."""
        logger.info("Creating new category")
        logger.debug(f"Category data: {category_data}")
        
        if not isinstance(category_data, MutableMapping):
            error_msg = "Category data must be a dictionary"
            logger.error(error_msg)
            raise ValueError(error_msg)
            
        try:
            category_data = dict(category_data)
            
            if '_id' not in category_data:
                logger.debug("No _id provided, MongoDB will generate one")
            
            result = self.db.categories.insert_one(category_data)
            category_id = str(result.inserted_id)
            logger.info(f"Category created successfully with ID: {category_id}")
            return category_id
            
        except Exception as e:
            self._handle_mongodb_error('create_category', 'categories', e)

    @keyword('Get Category')
    def get_category(self, category_id):
        """Retrieve a category by ID."""
        logger.info(f"Retrieving category with ID: {category_id}")
        
        try:
            converted_id = self._convert_id(category_id)
            category = self.db.categories.find_one({"_id": converted_id})
            
            if category:
                logger.debug(f"Found category: {category}")
                return json.loads(json.dumps(category, default=str))
            else:
                logger.warning(f"No category found with ID: {category_id}")
                return None
                
        except Exception as e:
            logger.error(f"Error retrieving category {category_id}: {str(e)}")
            return None

    @keyword('Update Category')
    def update_category(self, category_id, update_data):
        """Update a category with new data."""
        logger.info(f"Updating category with ID: {category_id}")
        logger.debug(f"Update data: {update_data}")
        
        try:
            update_data = dict(update_data)
            
            if '_id' in update_data:
                logger.debug("Removing _id from update data as it's immutable")
                del update_data['_id']
                
            if not update_data:
                logger.warning("No fields to update after removing _id")
                return 0
                
            converted_id = self._convert_id(category_id)
            result = self.db.categories.update_one(
                {"_id": converted_id},
                {"$set": update_data}
            )
            
            if result.matched_count == 0:
                logger.warning(f"No category found with ID: {category_id}")
            else:
                logger.info(f"Successfully updated {result.modified_count} category(ies)")
                
            return result.modified_count
            
        except Exception as e:
            self._handle_mongodb_error('update_category', 'categories', e, category_id)

    @keyword('Delete Category')
    def delete_category(self, category_id):
        """Delete a category by ID."""
        logger.info(f"Deleting category with ID: {category_id}")
        
        try:
            converted_id = self._convert_id(category_id)
            result = self.db.categories.delete_one({"_id": converted_id})
            
            if result.deleted_count == 0:
                logger.warning(f"No category found with ID: {category_id}")
            else:
                logger.info(f"Successfully deleted {result.deleted_count} category(ies)")
                
            return result.deleted_count
            
        except Exception as e:
            logger.error(f"Error deleting category {category_id}: {str(e)}")
            return 0