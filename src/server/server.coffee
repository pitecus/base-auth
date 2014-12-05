# Libraries.
express = require 'express'
logger = require 'morgan'
session = require 'express-session'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
fs = require 'fs'

# Configuration.
config = require './conf/app.json'

# Database library.
db = require './lib/database'

# Authentication library.
auth = require('./lib/authentication') db.models.User

# Routes.
routes =
  'api_v1_user': require('./routes/auth/user') express.Router(), db, auth
  'auth_google': require('./routes/auth/google') express.Router(), auth.passport

# Setup the Express server.
expressSetup = (app) ->
  app.set 'port', process.env.PORT || 3000
  app.set 'query parser', 'simple'
  app.disable 'etag'
  app.use logger 'dev'
  app.use express.static '../static'

# Passport (Authentication)
expressPassport = (app, auth) ->
  app.use cookieParser()
  app.use bodyParser.json()
  app.use bodyParser.urlencoded extended: true
  app.use session
    secret: 'keyboard cat'
    resave: true
    saveUninitialized: true
  app.use auth.passport.initialize()
  app.use auth.passport.session()

# Setup the application.
server = express()
expressSetup server
expressPassport server, auth

# TODO: Authorization

# Mongo connection.
db.connect config.mongo.username, config.mongo.password, config.mongo.server, config.mongo.collection
.then ->
  console.log 'Database connection successful!'
, (err) ->
  console.log 'Database connection error:', err
  process.exit -1 if process.env.ENVIRONMENT != 'sandbox'

# Routing system.
server.use '/auth/google', routes.auth_google

# API calls.
server.use '/api/v1/user', routes.api_v1_user

# Start the server app.
server.listen server.get('port'), ->
  console.log 'Express server listening on port', server.get 'port'