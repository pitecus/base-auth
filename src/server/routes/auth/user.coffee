# Log library.
log = require('../../lib/log') module.filename

# Provide information about the user logged in and menu header.
module.exports = (router, db, auth) ->
  # Routing.
  router.get '/profile', (req, res) ->
    # Initial values.
    email = ''
    name = ''

    # Navigation bar.
    _navbar = []

    # If the user is authenticated.
    if req.isAuthenticated()
      # Need to retrieve the data from database.
      email = req.user.email
      name = req.user.name

      # Menu after logged in.
      _navbar.push
        'label': 'Resource A'
        'path': '/resource-a'
      ,
        'label': 'Resource B'
        'path': '/resource-b'

    # Create navbar.
    _navbar.push
      'label': 'About'
      'path': '/about'

    # Return the data.
    res.type 'json'
    res.send JSON.stringify
      'email': email
      'displayName': name
      'navbar': _navbar

  return router