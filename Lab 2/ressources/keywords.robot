*** Settings ***
Library    SeleniumLibrary
Variables  ../po/variable.py
Variables  ../po/locator.py
Library    ../ressources/AskInput.py
Library    ../ressources/AskRadio.py
Library    ../ressources/AskSelect.py

*** Keywords ***
Open browser on home page
    Open Browser    ${HOME_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${PAGE_TEXT}    10
    Sleep    5
Close the browser
    Close Browser

Login should succeed with valid credentials
    Click Link    ${LOGIN_LINK}
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_INPUT}    ${VALID_PASSWORD}
    Click Button    ${SUBMIT_BUTTON}
    Sleep    5

Login should fail with missing credentials
    Click Link    ${LOGIN_LINK}
    Wait Until Page Contains Element    ${EMAIL_INPUT}    3
    Sleep    5
    Click Button    ${SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${EMAIL_INPUT}    3
    Sleep    5

Should be able to log out
    Click Link    ${LOGIN_LINK}
    Wait Until Page Contains Element    ${EMAIL_INPUT}    3
    Sleep    3
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_INPUT}    ${VALID_PASSWORD}
    Click Button    ${SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    3
    Sleep    5
    Click Link    ${LOGOUT_LINK}
    Sleep    3
Remember me checkbox should persist email address
    Click Link    ${LOGIN_LINK}
    Wait Until Page Contains Element    ${EMAIL_INPUT}    3
    Sleep    3
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_INPUT}    ${VALID_PASSWORD}
    Click Element    ${REMEMBER_ME_CHECKBOX}
    Click Button    ${SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    3
    Sleep    10
    Click Link    ${LOGOUT_LINK}
    Sleep    3
    Click Link    ${LOGIN_LINK}
    Sleep    10
    Wait Until Page Contains Element    ${EMAIL_INPUT}    3
    Textfield Value Should Be    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Sleep    5

Customers page should display multiple customers
    Click Link    ${LOGIN_LINK}
    Wait Until Page Contains Element    ${EMAIL_INPUT}    3
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_INPUT}    ${VALID_PASSWORD}
    Click Button    ${SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    5
    ${row_count}=    Get Element Count    ${CUSTOMERS_GRID}
    Should Be True    ${row_count} > 3
    Sleep    3

Should ba able to add a new customer
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    5
    Click Link    ${ADD_CUSTOMER_BUTTON}
    ${email}=    Ask Input    Please enter the email:
    Input Text    ${EMAIL_INPUT_ADD}    ${email}
    ${first_name}=    Ask Input    Please enter the first name:
    Input Text    ${FIRST_NAME_INPUT}    ${first_name}
    ${last_name}=    Ask Input    Please enter the last name:
    Input Text    ${LAST_NAME_INPUT}    ${last_name}
    ${city}=    Ask Input    Please enter the city:
    Input Text    ${CITY_INPUT}    ${city}
    ${state}=    Ask Select    Please select your state:
    Select From List By Label    ${STATE_INPUT}    ${state}
    ${gender}=    Ask Radio    Please select the gender:
    Run Keyword If    '${gender}' == 'Male'    Click Element    ${GENDER_RADIO_MALE}
    ...    ELSE    Click Element    ${GENDER_RADIO_FEMALE}
    Click Element    ${PROMOTIONNAL_CHECKBOX}
    Click Button    ${SAVE_BUTTON}
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    5
    Sleep    10

Should be able to cancel adding a new customer
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    5
    Click Link    ${ADD_CUSTOMER_BUTTON}
    Wait Until Page Contains Element    ${ADD_CUSTOMER_PAGE_TEXT}    5
    Sleep    5
    Click Element    ${CANCEL_BUTTON}
    Wait Until Page Contains Element    ${CUSTOMER_PAGE_TEXT}    5
    Sleep    5