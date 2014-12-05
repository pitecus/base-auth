# Authentication services.
define 'auth/auth-service', [
  'auth'
  'auth/session-service'
], (auth) ->
  # Load application.
  auth.factory 'authService', ['$http', 'sessionService', ($http, sessionService) ->
    # Should verify if the user have access.
    getProfile: ->
      return $http
        .get 'api/v1/user/profile'
        .then (res) ->
          console.log res.data
          return res.data

    # Identify if the user is authenticated.
    isAuthenticated: ->
      return !!sessionService.userId

    # Access control.
    isAuthorized: (authorizedRoles) ->
      authorizedRoles = [authorizedRoles] if !angular.isArray(authorizedRoles)
      return isAuthenticated() && authorizedRoles.indexOf(sessionService.userRole) != -1
  ]