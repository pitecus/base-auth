# Configure the Home Controller.
define 'tab/about-controller', [
  'auth'
], (auth) ->
  auth.controller 'aboutController', [
    '$scope'
    ($scope) ->
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'

  ]