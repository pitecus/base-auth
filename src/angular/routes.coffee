# Define the routing.
define 'routes', [
  'auth'
  'tab/home-controller'
  'tab/resourcea-controller'
  'tab/resourceb-controller'
  'tab/about-controller'
], (auth) ->
  auth.config ['$routeProvider', ($routeProvider) ->
    # Home page.
    $routeProvider.when '/',
      templateUrl: 'base-auth/templates/home.html'
      controller: 'homeController'
    # Resource A.
    $routeProvider.when '/resource-a',
      templateUrl: 'base-auth/templates/resource-a.html'
      controller: 'resourceaController'
    # Resource B.
    $routeProvider.when '/resource-b',
      templateUrl: 'base-auth/templates/resource-b.html'
      controller: 'resourcebController'
    # About.
    $routeProvider.when '/about',
      templateUrl: 'base-auth/templates/about.html'
      controller: 'aboutController'
    # Invalid routes redirects to Home Page.
    $routeProvider.otherwise
      redirectTo: '/'
  ]