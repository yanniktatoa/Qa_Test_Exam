*** Settings ***
Resource    ../ressources/keywords.robot
Suite Setup    Connexion MongoDB
Suite Teardown    Deconnexion MongoDB


*** Test Cases ***
Create Category - Valid Category 
    [Tags]    Valid    Create
    Create Category    ${CATEGORY_TEST_2}

Get Category - Valid Category 
    [Tags]    Valid    Get
    ${category_id}=    Convert To String    ${CATEGORY_TEST_2["_id"]}
    ${category}=    Get Category    ${category_id}
    Should Be Equal    ${category["name"]}    ${CATEGORY_TEST_2["name"]}
    Should Be Equal    ${category["description"]}    ${CATEGORY_TEST_2["description"]}

Update Category - Valid Category 
    [Tags]    Valid    Update
    ${category_id}=    Convert To String    ${CATEGORY_TEST_2["_id"]}
    Update Category    ${category_id}    ${UPDATE_CATEGORY}

Delete Category - Valid Category 
    [Tags]    Valid    Delete
    ${category_id}=    Convert To String    ${CATEGORY_TEST_2["_id"]}
    Delete Category    ${category_id}

Create Category - Missing Name 
    [Tags]    Invalid    Create
    Create Category    ${TEST_CATEGORY_MISSING_NAME}

Create Category - Missing Description 
    [Tags]    Invalid    Create
    Create Category    ${TEST_CATEGORY_MISSING_DESCRIPTION}

Get Category - Not Found ID 
    [Tags]    Invalid    Get
    Get Category    ${TEST_NOT_FOUND_ID}

Get Category - Bad Format ID 
    [Tags]    Invalid    Get
    Get Category    ${TEST_BAD_FORMAT_ID}

Update Category - Bad Format Name 
    [Tags]    Invalid    Update
    ${category_id}=    Convert To String    ${CATEGORY_TEST_2["_id"]}
    Update Category    ${category_id}    ${UPDATE_CATEGORY_BAD_FORMAT_NAME}

Update Category - Bad Format Image 
    [Tags]    Invalid    Update
    ${category_id}=    Convert To String    ${CATEGORY_TEST_2["_id"]}
    Update Category    ${category_id}    ${UPDATE_CATEGORY_BAD_FORMAT_IMAGE}

Delete Category - Not Found ID 
    [Tags]    Invalid    Delete
    Delete Category    ${TEST_NOT_FOUND_ID}

Delete Category - Bad Format ID 
    [Tags]    Invalid    Delete
    Delete Category    ${TEST_BAD_FORMAT_ID}

