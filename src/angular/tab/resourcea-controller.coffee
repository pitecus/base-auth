# Configure the Private Controller.
define 'tab/resourcea-controller', [
  'auth'
], (auth) ->
  auth.controller 'resourceaController', [
    '$scope'
    ($scope) ->
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'
  ]