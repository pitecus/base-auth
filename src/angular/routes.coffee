# Define the routing.
define 'routes', [
  'auth'
  'tab/home-controller'
  'tab/user-controller'
  'tab/about-controller'
], (auth) ->
  auth.config ['$routeProvider', ($routeProvider) ->
    # Home page.
    $routeProvider.when '/',
      templateUrl: 'base-auth/templates/home.html'
      controller: 'homeController'
    # Resource A.
    $routeProvider.when '/user',
      templateUrl: 'base-auth/templates/user.html'
      controller: 'userController'
    # About.
    $routeProvider.when '/about',
      templateUrl: 'base-auth/templates/about.html'
      controller: 'aboutController'
    # Invalid routes redirects to Home Page.
    $routeProvider.otherwise
      redirectTo: '/'
  ]