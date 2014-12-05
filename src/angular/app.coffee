# Authentication and authorization.
define 'app', [
  'auth'
  'routes'
  'auth/auth-service'
  'auth/navbar-directive'
  'auth/session-service'
], (auth) ->
  # Load application.
  auth.controller 'appController', ['$scope', '$location', '$route', 'authService', 'sessionService', ($scope, $location, $route, authService, sessionService) ->
    # Highlight the selected tab.
    $scope.navClass = (page) ->
      return if page == $location.path() then 'active' else ''

    # Loads the routes available.
    $scope.routes = []
    for k, v of $route.routes
      if v.label? then $scope.routes.push
        'label': v.label
        'path': k

    # Authentication status.
    $scope.isLogged = false
    $scope.authService = authService

    $scope.user = {}

    # Retrieve the user status.
    authService.getProfile()
    .then (data) ->
      $scope.isLogged = true if data.displayName != ''
      # TODO: Create the user session.
      $scope.user.displayName = data.displayName
      sessionService.create data.email, data.displayName
  ]