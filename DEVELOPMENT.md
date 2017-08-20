When developing your web application, the Citus™ IoT Platform requires it following some rules:

Relative URL in your HTML code:
===============================
By set **Export BASE_URL= as OS environment variable (Web Only)** to **FALSE** (default)

How it works!
------------

1. Web Browser: GET /apisrv/$BASE_URL/foo 
2. Application Gateway: GET /foo 
3. Your Application: GET /foo 

Compatible Solution:
-------------------

1. Your links in HTML code must refer to a relative URL path and <base> URL must be blank

```
  <base href="" target="_blank">
  <meta charset="UTF-8">
  <title>CLOUD INNOVATION®</title>
  <link rel="icon" type="image/png" href="images/favicon-32x32.png" sizes="32x32" />
  <link rel="icon" type="image/png" href="images/favicon-16x16.png" sizes="16x16" />
  <link href='css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='css/reset.css' media='print' rel='stylesheet' type='text/css'/>
  <link href='css/print.css' media='print' rel='stylesheet' type='text/css'/>
```
2. All of your AJAX call to backend API must detect the BASE_URL and set it as PREFIX


For WebSocket code:

```
var wsPrefix = (window.location.protocol == "http:" ? "ws://" : "wss://");
var wsUri = window.location.host + window.location.pathname;

wsClient = new WebSocket(wsPrefix + wsUri + "/ws/sensors");
```

For AngularJS code:
```
$http({
	method : 'POST',
	url : window.location.pathname + '/image/remove',
	data : {},
	headers : {
		'Authorization' : "Bearer " + localStorage.getItem("id_token")
	}
}).then(function(result) {
	}, function(error) {
});
```

Absolute URL in your HTML code:
===============================
By set **Export BASE_URL= as OS environment variable (Web Only)** to **TRUE**


How it works!
------------

1. Web Browser: GET /apisrv/$BASE_URL/foo 
2. Application Gateway: GET /apisrv/$BASE_URL/bar 
3. Your Application: GET /apisrv/$BASE_URL/bar 

Compatible Solution:
-------------------


