PRODUCT_TEST = {
    "_id": 2,
    "title": "Product Test",
    "price": 10.00,
    "description": "Test",
    "category": "test",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

PRODUCT_TEST_2 = {
    "_id": 3,
    "title": "Product Test 2",
    "price": 20.00,
    "description": "Test 2",
    "category": "test 2",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

UPDATE_PRODUCT = {
    "title": "Product Test 2 Updated",
    "price": 25.00,
    "description": "Test 2 Updated",
}

PRODUCT_TEST_3 = {
    "_id": 4,
    "title": "Product Test 3",
    "price": 30.00,
    "description": "Test 3",
    "category": "test 3",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

USER_TEST = {
    "_id": 2,
    "email": "test@example.com",
    "password": "test",
    "username": "test",
}

USER_TEST_2 = {
    "_id": 3,
    "email": "test2@example.com",
    "password": "test2",
    "username": "test2",
}

UPDATE_USER = {
    "email": "newtest2@example.com",
    "password": "newtest2",
    "username": "newtest2",
}

CART_TEST = {
    "_id": 2,
    "userId": 2,
    "products": [{
      "productId": 1,
      "quantity": 4
    }],
}

CART_TEST_2 = {
    "_id": 3,
    "userId": 3,
    "products": [{
      "productId": 2,
      "quantity": 1
    }],
}

UPDATE_CART = {
    "userId": 1,
    "products": [{
      "productId": 1,
      "quantity": 1
    },
    {
      "productId": 2,
      "quantity": 2
    }],
}

CATEGORY_TEST = {
    "_id": 2,
    "name": "Category Test",
    "description": "Test",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

CATEGORY_TEST_2 = {
    "_id": 3,
    "name": "Category Test 2",
    "description": "Test 2",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

UPDATE_CATEGORY = {
    "name": "Category Test 2 Updated",
    "description": "Test 2 Updated",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

PRODUCT_TEST_MISSING_PRICE = {
    "_id": 5,
    "title": "Product Test 4",
    "description": "Test 4",
    "category": "test 4",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

PRODUCT_TEST_MISSING_TITLE = {
    "_id": 6,
    "price": 40.00,
    "description": "Test 5",
    "category": "test 5",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

TEST_NOT_FOUND_ID = {
    "_id": 123,
}

TEST_BAD_FORMAT_ID = {
    "_id": "afgfg2232",
}

PRODUCT_TEST_BAD_FORMAT_PRICE = {
    "title": "Product Test 6",
    "price": "bad_format_price",
    "description": "Test 6",
    "category": "test 6",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

PRODUCT_TEST_BAD_FORMAT_CATEGORY = {
    "title": "Product Test 7",
    "price": 70.00,
    "description": "Test 7",
    "category": 2332,
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

USER_TEST_MISSING_EMAIL = {
    "_id": 7,
    "password": "test",
    "username": "test",
}

USER_TEST_MISSING_PASSWORD = {
    "_id": 8,
    "email": "test@example.com",
    "username": "test",
}

USER_TEST_BAD_FORMAT_USERNAME = {
    "email": "test@example.com",
    "password": "test",
    "username": 12212,
}

USER_TEST_BAD_FORMAT_PASSWORD = {
    "email": "test@example.com",
    "password": 1123121,
    "username": "test",
}

TEST_CART_MISSING_USER_ID = {
    "_id": 123,
    "products": [{
      "productId": 1,
      "quantity": 4
    }],
}

TEST_CART_BAD_FORMAT_DATE = {
    "_id": 123,
    "userId": 123,
    "date": "bad_format_date",
    "products": [{
      "productId": 1,
      "quantity": 4
    }],
}

UPDATE_CART_BAD_FORMAT_USER_ID = {
    "_id": 123,
    "userId": "bad_format_user_id",
    "products": [{
      "productId": 1,
      "quantity": 4
    }],
}

UPDATE_CART_BAD_FORMAT_PRODUCTS = {
    "_id": 123,
    "userId": 1,
    "products": 23323,
}

TEST_CATEGORY_MISSING_NAME = {
    "_id": 123,
    "description": "Test 8",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

TEST_CATEGORY_MISSING_DESCRIPTION = {
    "_id": 123,
    "name": "Test 9",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

UPDATE_CATEGORY_BAD_FORMAT_NAME = {
    "_id": 123,
    "name": 12212,
    "description": "Test 10",
    "image": "https://fakestoreapi.com/img/81fPKI62JHL._AC_SX679_.jpg"
}

UPDATE_CATEGORY_BAD_FORMAT_IMAGE = {
    "_id": 123,
    "description": "dffsdfdfdfd",
    "name": "Test 11",
    "image": 2354
}