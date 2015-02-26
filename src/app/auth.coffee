# Define the application.
define 'auth', [
  'angular'
  'angular-route'
  'angular-bootstrap']
, (angular) ->
  return angular.module 'auth', ['ngRoute', 'ui.bootstrap']