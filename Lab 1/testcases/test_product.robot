*** Settings ***
Resource    ../ressources/keywords.robot
Suite Setup    Connexion MongoDB
Suite Teardown    Deconnexion MongoDB


*** Test Cases ***
Create Product - Valid Product 
    [Tags]    Valid    Create
    Create Product    ${PRODUCT_TEST_3}

Get Product - Valid Product 
    [Tags]    Valid    Get
    ${product_id}=    Convert To String    ${PRODUCT_TEST["_id"]}
    ${product}=    Get Product    ${product_id}
    Should Be Equal    ${product["title"]}    ${PRODUCT_TEST["title"]}
    Should Be Equal    ${product["price"]}    ${PRODUCT_TEST["price"]}
    Should Be Equal    ${product["description"]}    ${PRODUCT_TEST["description"]}
    Should Be Equal    ${product["category"]}    ${PRODUCT_TEST["category"]}
    Should Be Equal    ${product["image"]}    ${PRODUCT_TEST["image"]}

Update Product - Valid Product 
    [Tags]    Valid    Update
    ${product_id}=    Convert To String    ${PRODUCT_TEST_2["_id"]}
    Update Product    ${product_id}    ${UPDATE_PRODUCT}

Delete Product - Valid Product 
    [Tags]    Valid    Delete
    ${product_id}=    Convert To String    ${PRODUCT_TEST_3["_id"]}
    Delete Product    ${product_id}

Create Product - Missing Price 
    [Tags]    Invalid    Create
    Create Product    ${PRODUCT_TEST_MISSING_PRICE}

Create Product - Missing Title 
    [Tags]    Invalid    Create
    Create Product    ${PRODUCT_TEST_MISSING_TITLE}

Get Product - Not Found ID 
    [Tags]    Invalid    Get
    Get Product    ${TEST_NOT_FOUND_ID}

Get Product - Bad Format ID 
    [Tags]    Invalid    Get
    Get Product    ${TEST_BAD_FORMAT_ID}

Update Product - Bad Format Price 
    [Tags]    Invalid    Update
    ${product_id}=    Convert To String    ${PRODUCT_TEST_2["_id"]}
    Update Product    ${product_id}    ${PRODUCT_TEST_BAD_FORMAT_PRICE}

Update Product - Bad Format Category 
    [Tags]    Invalid    Update
    ${product_id}=    Convert To String    ${PRODUCT_TEST_2["_id"]}
    Update Product    ${product_id}    ${PRODUCT_TEST_BAD_FORMAT_CATEGORY}

Delete Product - Bad Format ID 
    [Tags]    Invalid    Delete
    Delete Product    ${TEST_BAD_FORMAT_ID}

Delete Product - Not Found ID 
    [Tags]    Invalid    Delete
    Delete Product    ${TEST_NOT_FOUND_ID}
