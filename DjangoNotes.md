# DjangoProjectNotes

### After installation django check version

```
<b>$ python -m django --version</b>
```
or

```python
>>> import django
>>> print(django.get_version())
1.11

```

### Creating project

```
$ django-admin startproject mysite
```

### Development Server 

```
$ python manage.py runserver
```

### Changing Port

```
$ python manage.py runserver 8080
```

```
$ python manage.py runserver 0:8000
```

### Creating polls app

```
$ python manage.py startapp polls
```

### Writing first view

Open polls/views.py

```python
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
```

polls/urls.py

```python
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
]
```

mysite/urls.py

```python
from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', admin.site.urls),
]
   
```
### Check polls

```
$ python manage.py runserver
```
Go to http://localhost:8000/polls/

### Installation reportlab [Bug Fix]

when you see : 

```
Originally <type 'exceptions.TypeError'>: makeT1Font() argument 2 must be string, not None
```
http://www.reportlab.com/ftp/fonts/pfbfer.zip

unzip them in :

```
/path/to/your/python/site-packages/reportlab/fonts
```

### Responsing an image

main url
```
url(r'^polls/', include('polls.urls')),
```
poll url
```
url('bar', views.barchart, name='barchart'),
```
request 
```
http://localhost:8000/polls/bar/
```
poll view 
```python
def barchart(request):
	image_data = open('/home/mali/Desktop/graph/polls/barchart.jpg', "rb").read()
	return HttpResponse(image_data, content_type="image/png")
```

### Responsing an HTML Template & Configuring Template Directory

import 

```python
from django.template import Context, loader
from django.http import HttpResponse
```

response html 

```python
template = loader.get_template('polls/index.html')
context = {}
return HttpResponse(template.render(context, request))
```

in settings.py file // BASE_DIR = manage.py directory

```python
TEMPLATES = [
    {
	...
      	'DIRS': [os.path.join(BASE_DIR, 'polls/templates')],
        ...
    },
]

```

### Sending variable from View to Template (to html)

in view
```python
x=3
return render_to_response('polls/index.html', {'x':x})
```

in template
          
```javascript
var startserverboolean="{{startserverboolean}}";
console.log(startserverboolean);
if(startserverboolean=="True"){
                document.getElementById("CheckServer").innerHTML = "Check Server : i am true!";
                }
```
### Sending variable from View to Template (to javascript)

in view
```python
x=3
return render_to_response('polls/index.html', {'x':x})
```

in template 
```html
<h1>{{x}}</h1>
```

### Clicking a button to execute a python method with get (it does not reload page)

in polls/url.py
```python
urlpatterns = [
		url(r'^startserver/$', views.start_server, name='start_server')
	      ]
```

in template 

```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<button id="startServer">Start Server</button>
```

```javascript
 $('#startServer').click(function() {
              $.get("/polls/startserver/", function(response) {
                            document.getElementById("lastjob").innerHTML = "Server is started";
                            location.reload();

              });
            });
```



### Clicking a button to execute a python file with get parameter (it reloads page)

in view
```python
def index(request):
	context = {}
	if(request.GET.get('startserver')):
			        proc = subprocess.Popen(['sudo', 'python', 'tool.py', 'startserver'])
```

in template 
```html
<form action="" method="get">
    <input id = "startServer" type="submit" value="Start Server" name="startserver"/>
</form>
```
### Side by side divs (UI)

in template 

```html
<style>
.container {
    display: -webkit-flex;
}
</style>

<body>
        <section class="container">
		<div></div>
		<div></div>
</body>
```

### Execute command if  file exists or not

in view

```python
import os 
maincwd=os.getcwd()
PATH=maincwd+"/"+"filename"
    if os.path.isfile(PATH) and os.access(PATH, os.R_OK):
        proc = subprocess.Popen(['sudo', 'python', 'someanotherpython.py', 'withparameter'])
    else:
	print "nope"
```

### Send id:email dictionary to html table

in view

```python
tuplearray=[]
emaildict = {
               'headers': [u'ID :', u'Email'],
               'values'  : [],
}
with open(maincwd+"/email.log") as f:
	for line in f:
            tuplearray.append(line.split(':')[0])
            tuplearray.append(line.split(':')[1])
            emaildict['values'].append(tuplearray)
            tuplearray=[]

return render_to_response('polls/index.html', {'emaildict':emaildict})

```

in template 

```html
<div class="tablediv">
	<table>
	
	<!--Create header rows-->
	<tr>
	{% for header in emaildict.headers %}
		<th>{{header}}</th>
	{% endfor %}
	</tr>

	<!--Create element rows-->
	{% for value in emaildict.values %}
 		<tr>
 		{% for x in value %}
		<td>{{ x }}</td>
     		{% endfor %}
		</tr>
	{% endfor %}
	</table>
</div>
```

