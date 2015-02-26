# Configure the Home Controller.
define 'navbar/ctrl', [
  'auth'
], (auth) ->
  auth.controller 'NavbarCtrl', [
    '$scope'
    ($scope) ->
      console.log 'Yes, yes, yes'
      # When the route start to change, un-register from the pooling service.
      $scope.$on '$routeChangeStart', ->
        console.log 'Changing routes'
  ]