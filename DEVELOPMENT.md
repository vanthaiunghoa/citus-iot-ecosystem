When developing your web application, the Citus™ IoT Platform requires it following some rules:

Relative URL in your HTML code:
===============================
By set **Export BASE_URL= as OS environment variable (Web Only)** to **FALSE** (default) when registering your application image on the *Application Registration* feature.

How it works!
------------

1. Web Browser: GET $BASE_URL/foo 
2. Application Gateway: GET $BASE_URL/foo 
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

Better Use For Single Page Application
-----------------------------------------
**Frontend Technologies:**
+ Javascript
+ AngularJS
+ VueJS
+ React

**Backend Technologies:**
+ NodeJS
+ Java
+ Python
+ Groovy
+ Others

Absolute URL in your HTML code:
===============================
By set **Export BASE_URL= as OS environment variable (Web Only)** to **TRUE** when registering your application image on the *Application Registration* feature.


How it works!
------------

1. Web Browser: GET $BASE_URL/bar 
2. Application Gateway: GET $BASE_URL/bar 
3. Your Application: GET $BASE_URL/bar 

Compatible Solution:
-------------------

1. Your links in HTML code must refer to an absulute URL path and <base> URL must be set to $BASE_URL that passed by the Platform into ENVIRONMENT VARIABLES or every link must be added with $BASE_URL as prefix

Assume that BASE_URL=/apisrv/your-app-name~your-owner-id

Webpage with <base> is set and links are relative

```
  <meta charset="UTF-8">
  <base href="/apisrv/your-app-name~your-owner-id/" target="_blank">
  <title>CLOUD INNOVATION®</title>
  <link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32" />
  <link rel="icon" type="image/png" href="favicon-16x16.png" sizes="16x16" />
  <link href='css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='css/reset.css' media='print' rel='stylesheet' type='text/css'/>
  <link href='css/print.css' media='print' rel='stylesheet' type='text/css'/>
```

Webpage with absolute links built by using server side scripting languages

```
  <meta charset="UTF-8">
  <title>CLOUD INNOVATION®</title>
  <link rel="icon" type="image/png" href="/apisrv/your-app-name~your-owner-id/images/favicon-32x32.png" sizes="32x32" />
  <link rel="icon" type="image/png" href="/apisrv/your-app-name~your-owner-id/images/favicon-16x16.png" sizes="16x16" />
  <link href='/apisrv/your-app-name~your-owner-id/css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='/apisrv/your-app-name~your-owner-id/css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='/apisrv/your-app-name~your-owner-id/css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='/apisrv/your-app-name~your-owner-id/css/reset.css' media='print' rel='stylesheet' type='text/css'/>
  <link href='/apisrv/your-app-name~your-owner-id/css/print.css' media='print' rel='stylesheet' type='text/css'/>
```

2. Your backend web service neet to route all the request with $BASE_URL prefix

Example in Python:

```
@app.route('/')
def index():
    return app.send_static_file('index.html')
```

You need to fix the prefix base by using this code:

```
def initRouteWithPrefix(route_function, prefix='', mask='{0}{1}'):
  '''
    Defines a new route function with a prefix.
    The mask argument is a `format string` formatted with, in that order:
      prefix, route
  '''
  def newroute(route, *args, **kwargs):
    '''New function to prefix the route'''
    return route_function(mask.format(prefix, route), *args, **kwargs)
  return newroute

if os.environ.get('BASE_URL') is not None:
    app = Flask(__name__, static_url_path = os.environ['BASE_URL'])
    app.route = initRouteWithPrefix(app.route, os.environ['BASE_URL'])
else:
    app = Flask(__name__, static_url_path = "")
```

Better Use For Multipe Pages Application
-----------------------------------------
**Frontend Technologies:**
+ Server rendering to HTML/CSS/Javascript using View Engine

**Backend Technologies:**
+ NodeJS
+ Java
+ Python
+ Groovy
+ Others
