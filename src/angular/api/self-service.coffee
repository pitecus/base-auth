# Authentication services.
define 'api/self-service', [
  'auth'
], (auth) ->
  # Load application.
  auth.factory 'selfService', ['$http', 'sessionService', ($http, sessionService) ->
    # Should verify if the user have access.
    getProfile: ->
      return $http
        .get 'api/v1/self'
        .then (res) ->
          return res.data

    # Identify if the user is authenticated.
    isAuthenticated: ->
      return !!sessionService.userId

    # Access control.
    isAuthorized: (authorizedRoles) ->
      authorizedRoles = [authorizedRoles] if !angular.isArray(authorizedRoles)
      return isAuthenticated() && authorizedRoles.indexOf(sessionService.userRole) != -1
  ]