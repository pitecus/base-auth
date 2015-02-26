# Directive for Navigation Bar.
define 'navbar/directive', [
  'auth'
], (auth) ->
  auth.directive 'navbarDirective', [ ->
    # Return.
    templateUrl: 'templates/navbar.html'
  ]