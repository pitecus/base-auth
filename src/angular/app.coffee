# Authentication and authorization.
define 'app', [
  'auth'
  'routes'
  'api/self-service'
  'auth/navbar-directive'
  'auth/session-service'
], (auth) ->
  # Load application.
  auth.controller 'appController', ['$scope', '$location', '$route', 'selfService', 'sessionService', ($scope, $location, $route, selfService, sessionService) ->
    # Highlight the selected tab.
    $scope.isActive = (page) ->
      return if page == $location.path() then 'active' else ''

    # Loads the routes available.
    $scope.routes = []

    # Authentication status.
    $scope.isLogged = false
    $scope.selfService = selfService

    $scope.user = {}

    # Retrieve the user status.
    selfService.getProfile()
    .then (data) ->
      $scope.isLogged = true if data.displayName != ''
      # TODO: Create the user session.
      $scope.user.displayName = data.displayName
      sessionService.create data.email, data.displayName

      # Navbar.
      for arr in data.navbar
        $scope.routes.push
          'label': arr.label
          'path': arr.path
  ]