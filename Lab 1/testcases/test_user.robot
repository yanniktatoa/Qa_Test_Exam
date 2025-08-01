*** Settings ***
Resource    ../ressources/keywords.robot
Suite Setup    Connexion MongoDB
Suite Teardown    Deconnexion MongoDB


*** Test Cases ***
Create User - Valid User 
    [Tags]    Valid    Create
    Create User    ${USER_TEST_2}

Get User - Valid User 
    [Tags]    Valid    Get
    ${user_id}=    Convert To String    ${USER_TEST_2["_id"]}
    ${user}=    Get User    ${user_id}
    Should Be Equal    ${user["email"]}    ${USER_TEST["email"]}
    Should Be Equal    ${user["password"]}    ${USER_TEST["password"]}
    Should Be Equal    ${user["username"]}    ${USER_TEST["username"]}


Update User - Valid User 
    [Tags]    Valid    Update
    ${user_id}=    Convert To String    ${USER_TEST_2["_id"]}
    Update User    ${user_id}    ${UPDATE_USER}

Delete User - Valid User 
    [Tags]    Valid    Delete
    ${user_id}=    Convert To String    ${USER_TEST_2["_id"]}
    Delete User    ${user_id}

Create User - Missing Email 
    [Tags]    Invalid    Create
    Create User    ${USER_TEST_MISSING_EMAIL}

Create User - Missing Password 
    [Tags]    Invalid    Create
    Create User    ${USER_TEST_MISSING_PASSWORD}

Get User - Bad Format ID 
    [Tags]    Invalid    Get
    Get User    ${TEST_BAD_FORMAT_ID}

Get User - Not Found ID 
    [Tags]    Invalid    Get
    Get User    ${TEST_NOT_FOUND_ID}

Update User - Bad Format Username 
    [Tags]    Invalid    Update
    ${user_id}=    Convert To String    ${USER_TEST["_id"]}
    Update User    ${user_id}    ${USER_TEST_BAD_FORMAT_USERNAME}

Update User - Bad Format Password 
    [Tags]    Invalid    Update
    ${user_id}=    Convert To String    ${USER_TEST["_id"]}
    Update User    ${user_id}    ${USER_TEST_BAD_FORMAT_PASSWORD}

Delete User - Bad Format ID 
    [Tags]    Invalid    Delete
    Delete User    ${TEST_BAD_FORMAT_ID}

Delete User - Not Found ID 
    [Tags]    Invalid    Delete
    Delete User    ${TEST_NOT_FOUND_ID}




