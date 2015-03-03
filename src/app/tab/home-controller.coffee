# Configure the Home Controller.
define 'tab/home-controller', [
  'app'
], (app) ->
  app.controller 'homeController', [
    '$scope'
    ($scope) ->
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'

  ]