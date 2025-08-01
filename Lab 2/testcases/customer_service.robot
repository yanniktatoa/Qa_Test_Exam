*** Settings ***
Library    SeleniumLibrary
Resource   ../ressources/keywords.robot

*** Test Cases ***
Home page should load
    [Tags]    Smoke    Home
    Open browser on home page
    Close browser

Login should succeed with valid credentials
    [Tags]    Smoke    Login
    Open browser on home page
    Login should succeed with valid credentials
    Close browser

Login should fail with missing credentials
    [Tags]    Login    Negative
    Open browser on home page
    Login should fail with missing credentials
    Close browser

Should be able to log out
    [Tags]    Login    Logout
    Open browser on home page
    Should be able to log out
    Close browser

Remember me checkbox should persist email address
    [Tags]    Login    RememberMe
    Open browser on home page
    Remember me checkbox should persist email address
    Close browser
Customers page should display multiple customers
    [Tags]    Smoke    Contacts
    Open browser on home page
    Customers page should display multiple customers
    Close browser

Should ba able to add a new customer
    [Tags]    Contacts    Add
    Open browser on home page
    Login should succeed with valid credentials
    Should ba able to add a new customer
    Close browser

Should be able to cancel adding a new customer
    [Tags]    Contacts    Cancel
    Open browser on home page
    Login should succeed with valid credentials
    Should be able to cancel adding a new customer
    Close browser

