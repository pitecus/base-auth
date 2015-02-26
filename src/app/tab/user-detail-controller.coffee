# Configure the Private Controller.
define 'tab/user-detail-controller', [
  'auth'
  'api/user-service'
], (auth) ->
  auth.controller 'userDetailController', [
    '$scope'
    '$routeParams'
    'userService'
    ($scope, $routeParams, userService) ->
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'

      # Route params ID.
      userService.get $routeParams.id
      .then (data) ->
        console.log JSON.stringify data
        $scope.user = data
  ]