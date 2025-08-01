*** Settings ***
Library           AppiumLibrary
Resource          ../ressources/mobile.robot

*** Test Cases ***
Login Test
    Open Application loomaApk
    Enter credentials
    Log In
Fill the Form
    Fill the Form
Check Product
    Check Product