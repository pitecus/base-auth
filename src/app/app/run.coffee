# Check if the user is logged or not.
define 'app/run', [
  'app'
  'app/auth-factory'
], (app, auth) ->
  # Load application.
  app.run [
    '$rootScope'
    '$cookies'
    'appAuthFactory'
    ($rootScope, $cookies, appAuthFactory) ->
      console.log 'app/run: init'

      # Check if user is authenticated.
      appAuthFactory.isAuthenticated()
      .then (user) ->
        console.log 'broadcast auth-login-success'
        $rootScope.$broadcast 'auth-login-success', appAuthFactory.getUser()
      , (reason) ->
        console.log 'app/run: fail:', reason
      , (update) ->
        console.log 'app/run: update:', update
  ]

  # Return.
  app
