*** Settings ***
Library           RequestsLibrary
Variables         ../po/variable.py
Variables         ../po/locator.py

*** Keywords ***
Get All Orders
    Create Session    ebay    ${BASE_URL}    headers=${HEADERS}
    ${response}=      GET On Session    ebay    ${getOrders_endpoint}
    Log To Console    Status: ${response.status_code}
    ${body}=    Convert To String    ${response.content}
    Log To Console    Body: ${body}

Get All Orders Invalid
    Create Session    ebay    ${BASE_URL}    headers=${HEADERS}
    ${resp}=    GET On Session    ebay    ${getOrder_endpoint.replace('{orderId}', '${ORDERS_ID_INVALID}')}
    Log To Console    Status: ${resp.status_code}
    ${body}=    Convert To String    ${resp.content}
    Log To Console    Body: ${body}

Get Order Invalid
    Create Session    ebay    ${BASE_URL}    headers=${HEADERS}
    ${resp}=    GET On Session    ebay    ${getOrder_endpoint.replace('{orderId}', '${ORDER_ID_INVALID}')}
    Log To Console    Status: ${resp.status_code}
    ${body}=    Convert To String    ${resp.content}
    Log To Console    Body: ${body}

Issue Refund
    Create Session    ebay    ${BASE_URL}    headers=${HEADERS}
    ${body}=    Create Dictionary    refundReason=BUYER_CANCELLED    comments=Test refund
    ${resp}=    POST On Session    ebay    ${issueRefund_endpoint.replace('{orderId}', '${ORDER_ID_INVALID}')}    json=${body}
    Log To Console    Status: ${resp.status_code}
    ${body}=    Convert To String    ${resp.content}
    Log To Console    Body: ${body}

