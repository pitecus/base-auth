# Authentication and authorization.
define 'app', [
  'routes'
  'navbar/directive'
  'navbar/ctrl'
], (auth) ->
  # Load application.
  auth.controller 'appController', ['$scope', '$location', '$route', ($scope, $location, $route) ->
    # Highlight the selected tab.
    $scope.isActive = (page) ->
      return if $location.path().indexOf(page) == 0 then 'active' else ''

    # Loads the routes available.
    # $scope.routes = []

    # Authentication status.
    # $scope.isLogged = false
    # $scope.selfService = selfService

    # $scope.user = {}

    # Retrieve the user status.
    # selfService.getProfile()
    # .then (data) ->
    #   $scope.isLogged = true if data.displayName != ''
    #   # TODO: Create the user session.
    #   $scope.user.displayName = data.displayName
    #   sessionService.create data.email, data.displayName

    #   # Navbar.
    #   for arr in data.navbar
    #     $scope.routes.push
    #       'label': arr.label
    #       'path': arr.path
  ]