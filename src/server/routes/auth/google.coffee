module.exports = (router, passport) ->
  # Routing.
  router.get '/login', passport.authenticate 'google'
  router.get '/callback', passport.authenticate 'google',
    successRedirect: '/'
    failureRedirect: '/'
  router.get '/logout', (req, res) ->
    req.logout()
    res.redirect '/'

  return router