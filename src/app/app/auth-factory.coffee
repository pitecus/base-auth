# Check if the user is logged or not.
define 'app/auth-factory', [
  'app'
  'users/service'
], (app) ->
  # Load application.
  app.factory 'appAuthFactory', [
    '$cookies'
    '$q'
    'usersService'
    ($cookies, $q, usersService) ->
      # Caches the user.
      _user = null

      # If the user is authenticated.
      isAuthenticated: ->
        # Promise.
        deferred = $q.defer()

        # If the user is cached, returns it.
        if _user?
          # Resolve the promise.
          deferred.resolve _user
        else if !$cookies.user_id
          # Check for id.
          deferred.reject 'Not authenticated'
        else
          usersService.get $cookies.user_id
          .success (data, status, headers, config) ->
            # Store locally for future requests.
            _user = data
            # Resolve the promise.
            deferred.resolve _user
          .error (data, status, headers, config) ->
            # TODO: remove the cookie id.
            # Reject the promise.
            deferred.reject 'Invalid cookie id'

        # Return.
        deferred.promise

      # If the user is allowed to see it.
      isAuthorized: (path) ->
        # Promise.
        deferred = $q.defer()

        # TODO: Need to implement.
        deferred.resolve()

        # Return.
        deferred.promise

      # Get the user.
      getUser: ->
        # Return.
        _user
  ]

  # Return.
  app
