*** Settings ***
Resource    ../ressources/keywords.robot
Suite Setup    Connexion MongoDB
Suite Teardown    Deconnexion MongoDB


*** Test Cases ***
Create Cart - Valid Cart 
    [Tags]    Valid    Create
    Create Cart    ${CART_TEST_2}

Get Cart - Valid Cart 
    [Tags]    Valid    Get
    ${cart_id}=    Convert To String    ${CART_TEST_2["_id"]}
    ${cart}=    Get Cart    ${cart_id}
    Should Be Equal    ${cart["userId"]}    ${CART_TEST_2["userId"]}
    Should Be Equal    ${cart["products"]}    ${CART_TEST_2["products"]}


Update Cart - Valid Cart 
    [Tags]    Valid    Update
    ${cart_id}=    Convert To String    ${CART_TEST_2["_id"]}
    Update Cart    ${cart_id}    ${UPDATE_CART}

Delete Cart - Valid Cart 
    [Tags]    Valid    Delete
    ${cart_id}=    Convert To String    ${CART_TEST["_id"]}
    Delete Cart    ${cart_id}

Create Cart - Missing User ID 
    [Tags]    Invalid    Create
    Create Cart    ${TEST_CART_MISSING_USER_ID}

Create Cart - Bad Format Date 
    [Tags]    Invalid    Create
    Create Cart    ${TEST_CART_BAD_FORMAT_DATE}

Get Cart - Bad Format ID 
    [Tags]    Invalid    Get
    Get Cart    ${TEST_BAD_FORMAT_ID}

Get Cart - Not Found ID 
    [Tags]    Invalid    Get
    Get Cart    ${TEST_NOT_FOUND_ID}

Update Cart - Bad Format User ID 
    [Tags]    Invalid    Update
    ${cart_id}=    Convert To String    ${CART_TEST_2["_id"]}
    Update Cart    ${cart_id}    ${UPDATE_CART_BAD_FORMAT_USER_ID}

Update Cart - Bad Format Products 
    [Tags]    Invalid    Update
    ${cart_id}=    Convert To String    ${CART_TEST_2["_id"]}
    Update Cart    ${cart_id}    ${UPDATE_CART_BAD_FORMAT_PRODUCTS}

Delete Cart - Bad Format ID 
    [Tags]    Invalid    Delete
    Delete Cart    ${TEST_BAD_FORMAT_ID}

Delete Cart - Not Found ID 
    [Tags]    Invalid    Delete
    Delete Cart    ${TEST_NOT_FOUND_ID}


