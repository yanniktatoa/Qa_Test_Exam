*** Settings ***
Library    Collections
Library    OperatingSystem
Library    ../library/MongoDBLibrary.py    WITH NAME    MongoDB
Variables    ../po/variable.py
Variables    ../po/locator.py

*** Keywords ***
Connexion MongoDB
    MongoDB.Connect To MongoDB    ${MONGODB_URI}    ${DB_NAME}

Deconnexion MongoDB
    MongoDB.Disconnect From MongoDB

Convertir En Dictionnaire
    [Arguments]    ${data}
    ${is_dict}    Run Keyword And Return Status    Evaluate    isinstance($data, dict)    $data
    Return From Keyword If    ${is_dict}    ${data}
    ${dict}    Evaluate    __import__('json').loads(r'''${data}''')
    RETURN    ${dict}

# Products Keywords
Create Product - Valid Product 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_produit}    MongoDB.Create Product    ${data_dict}
    Should Not Be Equal    ${id_produit}    ${None}
    ${produit}    MongoDB.Get Product    ${id_produit}
    RETURN    ${id_produit}

Get Product - Valid Product 
    [Arguments]    ${product_id}
    ${produit}    MongoDB.Get Product    ${product_id}
    RETURN    ${produit}

Update Product - Valid Product 
    [Arguments]    ${product_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Product    ${product_id}    ${new_data_dict}
    ${produit}    MongoDB.Get Product    ${product_id}
    RETURN    ${result}

Delete Product - Valid Product 
    [Arguments]    ${product_id}
    ${produit}    MongoDB.Get Product    ${product_id}
    ${result}    MongoDB.Delete Product    ${product_id}
    RETURN    ${result}

Create Product - Missing Price 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_produit}    MongoDB.Create Product    ${data_dict}
    Should Be Equal    ${id_produit}    ${None}
    RETURN    ${id_produit}

Create Product - Missing Title 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_produit}    MongoDB.Create Product    ${data_dict}
    Should Be Equal    ${id_produit}    ${None}
    RETURN    ${id_produit}

Get Product - Not Found ID 
    [Arguments]    ${product_id}
    ${produit}    MongoDB.Get Product    ${product_id}
    Should Be Equal    ${produit}    ${None}
    RETURN    ${produit}

Get Product - Bad Format ID 
    [Arguments]    ${product_id}
    ${produit}    MongoDB.Get Product    ${product_id}
    Should Be Equal    ${produit}    ${None}
    RETURN    ${produit}

Update Product - Bad Format Price 
    [Arguments]    ${product_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Product    ${product_id}    ${new_data_dict}
    ${produit}    MongoDB.Get Product    ${product_id}
    RETURN    ${result}

Update Product - Bad Format Category 
    [Arguments]    ${product_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Product    ${product_id}    ${new_data_dict}
    ${produit}    MongoDB.Get Product    ${product_id}
    RETURN    ${result}

Delete Product - Bad Format ID 
    [Arguments]    ${product_id}
    ${produit}    MongoDB.Get Product    ${product_id}
    ${result}    MongoDB.Delete Product    ${product_id}
    RETURN    ${result}

Delete Product - Not Found ID 
    [Arguments]    ${product_id}
    ${produit}    MongoDB.Get Product    ${product_id}
    ${result}    MongoDB.Delete Product    ${product_id}
    RETURN    ${result}

# Users Keywords
Create User - Valid User 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_user}    MongoDB.Create User    ${data_dict}
    Should Not Be Equal    ${id_user}    ${None}
    ${user}    MongoDB.Get User    ${id_user}
    RETURN    ${id_user}

Get User - Valid User 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    RETURN    ${user}

Update User - Valid User 
    [Arguments]    ${user_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update User    ${user_id}    ${new_data_dict}
    ${user}    MongoDB.Get User    ${user_id}
    RETURN    ${result}

Delete User - Valid User 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Create User - Missing Email 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Create User - Missing Password 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Get User - Bad Format ID 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Get User - Not Found ID 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Update User - Bad Format Username 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Update User - Bad Format Password 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Delete User - Not Found ID 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

Delete User - Bad Format ID 
    [Arguments]    ${user_id}
    ${user}    MongoDB.Get User    ${user_id}
    ${result}    MongoDB.Delete User    ${user_id}
    RETURN    ${result}

# Carts Keywords 
Create Cart - Valid Cart 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_cart}    MongoDB.Create Cart    ${data_dict}
    Should Not Be Equal    ${id_cart}    ${None}
    ${cart}    MongoDB.Get Cart    ${id_cart}
    RETURN    ${id_cart}

Get Cart - Valid Cart 
    [Arguments]    ${cart_id}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    RETURN    ${cart}

Update Cart - Valid Cart 
    [Arguments]    ${cart_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Cart    ${cart_id}    ${new_data_dict}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    RETURN    ${result}

Delete Cart - Valid Cart 
    [Arguments]    ${cart_id}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    ${result}    MongoDB.Delete Cart    ${cart_id}
    RETURN    ${result}

Create Cart Missing User ID 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_cart}    MongoDB.Create Cart    ${data_dict}
    Should Not Be Equal    ${id_cart}    ${None}
    ${cart}    MongoDB.Get Cart    ${id_cart}
    RETURN    ${id_cart}

Create Cart Bad Format Date
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_cart}    MongoDB.Create Cart    ${data_dict}
    Should Not Be Equal    ${id_cart}    ${None}
    ${cart}    MongoDB.Get Cart    ${id_cart}
    RETURN    ${id_cart}

Get Cart - Not Found ID 
    [Arguments]    ${cart_id}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    ${result}    MongoDB.Delete Cart    ${cart_id}
    RETURN    ${result}

Get Cart - Bad Format ID 
    [Arguments]    ${cart_id}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    ${result}    MongoDB.Delete Cart    ${cart_id}
    RETURN    ${result}

Update Cart - Bad Format User ID 
    [Arguments]    ${cart_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Cart    ${cart_id}    ${new_data_dict}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    RETURN    ${result}

Update Cart - Bad Format Products 
    [Arguments]    ${cart_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Cart    ${cart_id}    ${new_data_dict}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    RETURN    ${result}

Delete Cart - Not Found ID 
    [Arguments]    ${cart_id}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    ${result}    MongoDB.Delete Cart    ${cart_id}
    RETURN    ${result}

Delete Cart - Bad Format ID 
    [Arguments]    ${cart_id}
    ${cart}    MongoDB.Get Cart    ${cart_id}
    ${result}    MongoDB.Delete Cart    ${cart_id}
    RETURN    ${result}

# Categories Keywords
Create Category - Valid Category
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_category}    MongoDB.Create Category    ${data_dict}
    Should Not Be Equal    ${id_category}    ${None}
    ${category}    MongoDB.Get Category    ${id_category}
    RETURN    ${id_category}

Get Category - Valid Category 
    [Arguments]    ${category_id}
    ${category}    MongoDB.Get Category    ${category_id}
    RETURN    ${category}

Update Category - Valid Category 
    [Arguments]    ${category_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Category    ${category_id}    ${new_data_dict}
    ${category}    MongoDB.Get Category    ${category_id}
    RETURN    ${result}

Delete Category - Valid Category 
    [Arguments]    ${category_id}
    ${category}    MongoDB.Get Category    ${category_id}
    ${result}    MongoDB.Delete Category    ${category_id}
    RETURN    ${result}

Create Category - Missing Name 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_category}    MongoDB.Create Category    ${data_dict}
    Should Not Be Equal    ${id_category}    ${None}
    ${category}    MongoDB.Get Category    ${id_category}
    RETURN    ${id_category}

Create Category - Missing Description 
    [Arguments]    ${data}
    ${data_dict}    Convertir En Dictionnaire    ${data}
    ${id_category}    MongoDB.Create Category    ${data_dict}
    Should Not Be Equal    ${id_category}    ${None}
    ${category}    MongoDB.Get Category    ${id_category}
    RETURN    ${id_category}

Get Category - Not Found ID 
    [Arguments]    ${category_id}
    ${category}    MongoDB.Get Category    ${category_id}
    ${result}    MongoDB.Delete Category    ${category_id}
    RETURN    ${result}

Get Category - Bad Format ID 
    [Arguments]    ${category_id}
    ${category}    MongoDB.Get Category    ${category_id}
    ${result}    MongoDB.Delete Category    ${category_id}
    RETURN    ${result}

Update Category - Bad Format Name 
    [Arguments]    ${category_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Category    ${category_id}    ${new_data_dict}
    ${category}    MongoDB.Get Category    ${category_id}
    RETURN    ${result}

Update Category - Bad Format Image 
    [Arguments]    ${category_id}    ${new_data}
    ${new_data_dict}    Convertir En Dictionnaire    ${new_data}
    ${result}    MongoDB.Update Category    ${category_id}    ${new_data_dict}
    ${category}    MongoDB.Get Category    ${category_id}
    RETURN    ${result}

Delete Category - Not Found ID 
    [Arguments]    ${category_id}
    ${category}    MongoDB.Get Category    ${category_id}
    ${result}    MongoDB.Delete Category    ${category_id}
    RETURN    ${result}

Delete Category - Bad Format ID 
    [Arguments]    ${category_id}
    ${category}    MongoDB.Get Category    ${category_id}
    ${result}    MongoDB.Delete Category    ${category_id}
    RETURN    ${result}