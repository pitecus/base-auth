# ## Export the module
module.exports =
  hasAccess: (req, res, next) ->
    console.log 'authorization.hasAccess', req.isAuthenticated()
    # Carry on.
    return next() if req.isAuthenticated() == true

    # TODO: Should return a 410 unathorized.
    res.status 401
    .json {}