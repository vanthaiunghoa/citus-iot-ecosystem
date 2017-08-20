When developing your web application, the Citus™ IoT Platform requires it following some rules:

Relative URL in your HTML code:
===============================
By set **Export BASE_URL= as OS environment variable (Web Only)** to **FALSE** (default)

How it works!
------------

1. Web Browser: GET /foo 
2. Application Gateway: GET /apisrv/[APP_NAME]~[OWNERID]/foo 
3. Your Application: GET /foo 


Absolute URL in your HTML code:
===============================
By set **Export BASE_URL= as OS environment variable (Web Only)** to **TRUE**


How it works!
------------

1. Web Browser: GET /bar 
2. Application Gateway: GET /apisrv/[APP_NAME]~[OWNERID]/bar 
3. Your Application: GET /apisrv/[APP_NAME]~[OWNERID]/bar 
