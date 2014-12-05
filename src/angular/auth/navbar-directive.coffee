# Directive for Navigation Bar.
define 'auth/navbar-directive', [
  'auth'
], (auth) ->
  auth.directive 'navbarDirective', [ ->
    # Return.
    templateUrl: 'base-auth/templates/navbar.html'
  ]