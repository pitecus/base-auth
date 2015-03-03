# Configure the Private Controller.
define 'users/list-ctrl', [
  'app'
  'users/service'
], (app) ->
  app.controller 'usersListCtrl', [
    '$scope'
    'usersService'
    ($scope, usersService) ->
      usersService.list()
      .success (data) ->
        console.log 'users/list-ctrl: data=', data
        $scope.list = data
  ]
