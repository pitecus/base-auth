# Logging system.
log = require('./log') module.filename

passport = require 'passport'
GoogleStrategy = require('passport-google').Strategy

User = require '../api/users/model'

# Setup the passport to use Google Authorization.
passport.use new GoogleStrategy
  returnURL: 'http://127.0.0.1:3000/auth/google/return'
  realm: 'http://127.0.0.1:3000/'
, (identifier, profile, done) ->
  User.findOne 'identifier': identifier
  .exec (err, user) ->
    # On error.
    return done err, null if err?

    # User found, return it.
    # TODO: need to update data from profile if it changes.
    return done err, user if user?

    # Create user.
    User.create
      'provider': profile.provider
      'identifier': identifier
      'displayName': profile.displayName
      'name': profile.name.givenName + ' ' + profile.name.familyName
      'emails': profile.emails
    , (err, user) ->
      # On error.
      return done err, null if err?

      # Return the user.
      done err, user

      # Return.
      true
    # Return
    true
  # Return
  true

# .
passport.serializeUser (user, done) ->
  #console.log 'serializeUser:', user
  done null, user.id

# TODO: need to receive the user model.
passport.deserializeUser (id, done) ->
  #console.log 'deserializeUser:', id
  User.findById id
  .lean() # Returns a plain JavaScript object.
  .exec (err, user) ->
    # Convert the objectID.
    user.id = user._id.toString()
    done err, user

# ## Export the module
module.exports = passport