*** Settings ***
Resource    ../ressources/keywords.robot

*** Test Cases ***
Get All Orders
    [Tags]    ebay    Get_All_Orders
    Get All Orders

Get All Orders Invalid
    [Tags]    ebay    Get_All_Orders_Invalid
    Get All Orders Invalid
    
Get Order Invalid
    [Tags]    ebay    Get_Order_Invalid
    Get Order Invalid

Issue Refund
    [Tags]    ebay    Issue_Refund
    Issue Refund



