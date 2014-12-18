# Log library.
log = require('../../lib/log') module.filename

# Provide information about the user logged in and menu header.
module.exports = (router, db, auth) ->
  # GET.
  router.get '/', (req, res) ->
    # If the user is authenticated.
    if !req.isAuthenticated()
      res.send 401
      return

    # Initial values.
    _users = []

    # If the user is authenticated.
    db.models.User
    .find {}
    .sort 'name, email'
    .exec (err, docs) ->
      for doc in docs
        _users.push
          id: doc._id
          name: doc.name
          email: doc.email
          status: doc.status

      # Return the data.
      res.type 'json'
      res.send JSON.stringify _users

  # GET detail.
  router.get '/:id', (req, res) ->
    # If the user is authenticated.
    if !req.isAuthenticated()
      res.send 401
      return

    # If the user is authenticated.
    db.models.User
    .findOne {'id': req.param.id}
    .sort 'name, email'
    .exec (err, doc) ->
      # Return the data.
      res.type 'json'
      console.log JSON.stringify doc
      res.send JSON.stringify
        'id': doc._id
        'name': doc.name
        'email': doc.email
        'status': doc.status

  return router