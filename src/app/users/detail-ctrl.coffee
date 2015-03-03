# Configure the Private Controller.
define 'users/detail-ctrl', [
  'app'
  'users/service'
], (app) ->
  app.controller 'usersDetailCtrl', [
    '$scope'
    '$routeParams'
    'usersService'
    ($scope, $routeParams, usersService) ->
      # Retrieve the id.
      _id = $routeParams.id

      $scope.user = {}
      usersService.get _id
      .success (data) ->
        console.log 'users/detail-ctrl: data=', data
        $scope.user = data
  ]
