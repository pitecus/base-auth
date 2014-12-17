# Authentication services.
define 'api/user-service', [
  'auth'
], (auth) ->
  # Load application.
  auth.factory 'userService', ['$http', 'sessionService', ($http, sessionService) ->
    # Should verify if the user have access.
    list: ->
      return $http
        .get 'api/v1/user'
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