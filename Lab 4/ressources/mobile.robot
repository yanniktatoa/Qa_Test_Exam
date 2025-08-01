*** Settings ***
Library           AppiumLibrary
Variables        ../po/variable.py
Variables        ../po/locator.py

*** Keywords ***
Open Application loomaApk
    Open Application       ${REMOTE_URL}   platformName=${PLATFORM_NAME}    
    ...    deviceName=${DEVICE_NAME}    automationName=${AUTOMAT_NAME}    
    ...    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    
    ...    noReset=true
    
Enter credentials
    Wait Until Element Is Visible    ${USERNAME}    5
    Click Element    ${USERNAME}
    Input Text    ${USERNAME}    ${CREDENTIALS}
    Click Element    ${PASSWORD}
    Input Password    ${PASSWORD}    ${PASSWD}

Log In
    Wait Until Element Is Visible    ${LOGIN}    5
    Click Element    ${LOGIN}
    Wait Until Page Contains Element    ${PAGE_FORM}

Fill the Form
    Wait Until Element Is Visible    ${FORM_TITLE}    5
    Click Element                    ${FORM_TITLE}
    Input Text                       ${FORM_TITLE}        ${TITLE}

    Wait Until Element Is Visible    ${FORM_PRICE}    5
    Click Element                    ${FORM_PRICE}
    Input Text                       ${FORM_PRICE}        ${PRICE}

    Wait Until Element Is Visible    ${FORM_DESCRIPTION}    5
    Click Element                    ${FORM_DESCRIPTION}
    Input Text                       ${FORM_DESCRIPTION}    ${DESCRIPTION}

    Wait Until Element Is Visible    ${FORM_CATEGORIE}    5
    Click Element                    ${FORM_CATEGORIE}
    Input Text                       ${FORM_CATEGORIE}      ${CATEGORIE}

    Wait Until Element Is Visible    ${FORM_URL}    5
    Click Element                    ${FORM_URL}
    Input Text                       ${FORM_URL}            ${URL}

    Wait Until Element Is Visible    ${FORM_BUTTON_ADD}    5
    Click Element                    ${FORM_BUTTON_ADD}

Check Product
    Wait Until Page Contains Element    ${PROD_PAGE_TITLE}    5
    Click Element    ${PROD_PAGE_OBJECT}