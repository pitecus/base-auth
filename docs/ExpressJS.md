# Express JS

```javascript
var express = require('express');
var app = express();

app.get('/', function(err, req, res) {
  // If there is an error.
  if (err) {
    res.send('Some issue is here');
    return;
  }

  // Return the content.
  res.send('Hello world!');
});

app.listen(3000);
```

## Dependencies

### Morgan - for dev purpose only

### Body parser module

Middleware to handle POST data.

```shell
npm install --save body-parser
```

```javascript
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
```

### Cookie parser

Tell express to use cookie-parser middleware.

```shell
npm install --save cookie-parser
```

```javascript
app.use(cookieParser());
```
### Express session

Tell express to handle Session.

```bash
npm install --save express-session
```

```javascript
app.use(session({
  'secret': '$#%!@#@@#SSDASASDVV@@@@',
  'key': 'sid'
}));
```
#### Login

```javascript
app.get('/login', function(req, res) {
  var
    sess;
  
  //Session initialized.
  sess = req.session;

  // Setup email.
  sess.email = 'pitecus@gmail.com';
});
```

#### Logout

```javascript
app.get('/logout', function(req, res) {
  req.session.destroy(function(err) {
    if (err) {
       console.log(err);
    } else { 
       //Session destroyed, redirect to home page.
       res.redirect('/');
    }
  }
});
```

Tell express from where to server the static files.

```javascript
app.use(express.static(__dirname + '/folder_name'));
```

## Routes

### Handling GET Request

```javascript
app.get('/', function(req, res) {
  // Render index template.
  res.render('index');
});
```

### Handling GET with parameters

```shell
curl http://localhost:3000/profile?id=100022
```

```javascript
app.get('/profile', function(req, res) {
  var
    profile_id;

  profile_id = req.query.id;
  res.render('profile', {'id': profile_id});
});
```

### Handling POST

```javascript
app.post('/login', function(req, res) {
  var
    email,
    password;

  email = req.body.email;
  password  = req.body.password;

  res.json({'done': 'yes'});
  // OR
  res.render('account');
});
```