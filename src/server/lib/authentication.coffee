log = require('./log') module.filename

passport = require 'passport'

# Authentication strategy.
GoogleStrategy = require 'passport-google'
.Strategy

module.exports = (User) ->

  # Authentication Middleware.
  passport.use new GoogleStrategy
    returnURL: 'http://localhost:3000/auth/google/callback',
    realm: 'http://localhost:3000/'
  ,
    (identifier, profile, done) ->
      # Data object.
      data =
        openId: identifier
        email: profile.emails[0].value
        name: profile.displayName

      # Retrieve the user from database.
      User.findOne 'email': data.email, (err, userDB) ->
        # Error.
        return done err if err

        # Return in success.
        return done null, userDB if userDB != null

        # Create the user.
        data.status = 'Pending'
        User.create data, (err2, userDB2) ->
          # Error.
          return done err if err

          # Return.
          return done null, userDB2

  # Sessions (optional)
  passport.serializeUser (user, done) ->
    done null, user._id

  passport.deserializeUser (id, done) ->
    User.findOne id, (err, user) ->
      done err, user

  # Check that the user is logged.
  isLogged = (req, res, next) ->
    # All is good.
    return next() if req.isAuthenticated()

    # No access should return 401 Not Authorized.
    res.statusCode = 401
    res.end ''

  # ## Export the module
  auth =
    isLogged: isLogged
    passport: passport
  return auth