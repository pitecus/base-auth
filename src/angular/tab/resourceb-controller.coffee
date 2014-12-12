# Configure the Private Controller.
define 'tab/resourceb-controller', [
  'auth'
], (auth) ->
  auth.controller 'resourcebController', [
    '$scope'
    ($scope) ->
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'
  ]