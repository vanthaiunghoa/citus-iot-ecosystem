When developing your web application, the Citus™ IoT Platform requires it following some rules:

Relative URL in your HTML code:
-------------------------------
By set **Export BASE_URL= as OS environment variable (Web Only)** to **FALSE** (default)

How it works!
=============

1. Web Browser: GET / 
2. Application Gateway: GET /apisrv/[APP_NAME]~[OWNERID]/ 
3. Your Application: GET /


Absolute URL in your HTML code:
-------------------------------
By set **Export BASE_URL= as OS environment variable (Web Only)** to **TRUE**

1. Web Browser: *GET /* 
2. Application Gateway: *GET /apisrv/[APP_NAME]~[OWNERID]/*
3. Your Application: *GET /apisrv/[APP_NAME]~[OWNERID]/*
