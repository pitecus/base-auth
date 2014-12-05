# Define the routing.
define 'routes', [
  'auth'
  'tab/home-controller'
], (auth) ->
  auth.config ['$routeProvider', ($routeProvider) ->
    # Home page.
    $routeProvider.when '/',
      label: 'Home'
      templateUrl: 'base-auth/templates/home.html'
      controller: 'homeController'
    # Invalid routes redirects to Home Page.
    $routeProvider.otherwise
      redirectTo: '/'
  ]