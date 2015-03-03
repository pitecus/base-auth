# Directive for Navigation Bar.
define 'navbar/directive', [
  'app'
], (app) ->
  app.directive 'navbarDirective', [ ->
    # Return.
    'templateUrl': 'templates/navbar.html'
  ]
