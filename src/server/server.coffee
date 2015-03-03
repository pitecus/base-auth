# Logging system.
log = require('./lib/log') module.filename

# Load external libraries.
express      = require 'express'
logger       = require 'morgan'
bodyParser   = require 'body-parser'
cookieParser = require 'cookie-parser'
session      = require 'express-session'

# Setup the application.
app = express()
app.set 'port', process.env.PORT || 3000
app.set 'query parser', 'simple'
app.disable 'etag'
app.use logger 'dev'
app.use express.static '../web'

# Cookie parser.
app.use cookieParser()

# Parsing post.
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true

# Session.
app.use session secret: 'Am9cUp3eD4EwiB1iS9Uj7o'

# Passport.
passport = require './lib/passport'
app.use passport.initialize()
app.use passport.session()

# Passport routes.
app.get '/auth/google/login', passport.authenticate 'google'
app.get '/auth/google/return', passport.authenticate 'google',
  'successRedirect': '/auth/google/cookie'
  'failureRedirect': '/auth/google/logout'
app.get '/auth/google/cookie', (req, res) ->
  # Sets a cookie with the user id.
  if req.user and req.user.id
    res.cookie 'user_id', req.user.id,
      'maxAge': 300000 # 5 minutes
      'httpOnly': false

  # Redirects home.
  res.redirect '/'
app.get '/auth/google/logout', (req, res) ->
  res.clearCookie 'user_id'
  req.logout()
  res.redirect '/'

# Authorization.
authorization = require './lib/authorization'

# API calls.
app.use '/api/v1/users',    require './api/users'

# Mongo connection.
db = require './lib/database'
# use baseauth
# Mongo 2.4: db.addUser( { 'user': 'baseauth', 'pwd': 'a12345', 'roles': [ 'readWrite' ] } )
# Mongo 2.6: db.createUser( { 'user': 'baseauth', 'pwd': 'a12345', 'roles': [ { 'role': 'readWrite', 'db': 'baseauth' } ] } )
db.connect 'baseauth', 'a12345', '127.0.0.1', 'baseauth'
.then ->
  log.info 'Database connection successful!'
  # Start the server app.
  app.listen app.get('port'), ->
    log.info 'Express server listening on port', app.get 'port'
, (err) ->
  log.error 'Database connection error:' + err
  process.exit -1
