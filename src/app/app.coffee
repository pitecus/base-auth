# Define the module.
define 'app', [
  # External libraries.
  'angular'
  'angular-bootstrap'
  'angular-bootstrap-tpls'
  'angular-cookies'
  'angular-route'
], (angular) ->
  # Register module.
  app = angular.module 'app', [
    'ngCookies'
    'ngRoute'
    'ui.bootstrap'
  ], [
    ->
      console.log 'app.js: initialized app module'
  ]

  # Return.
  app