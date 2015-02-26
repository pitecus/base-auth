# Configure the Private Controller.
define 'tab/user-controller', [
  'auth'
  'api/user-service'
], (auth) ->
  auth.controller 'userController', [
    '$scope'
    'userService'
    ($scope, userService) ->
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'

      userService.list()
      .then (data) ->
        $scope.list = data
  ]