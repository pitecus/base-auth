log = require('../../lib/log') module.filename

module.exports = (router, db, auth) ->
  # Routing.
  router.get '/profile', (req, res) ->
    # Initial values.
    email = ''
    name = ''

    # If the user is authenticated.
    if req.isAuthenticated()
      # Need to retrieve the data from database.
      email = req.user.email
      name = req.user.name

    # Return the data.
    res.type 'json'
    res.send JSON.stringify
      email: email
      displayName: name

  return router