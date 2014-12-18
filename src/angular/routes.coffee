# Define the routing.
define 'routes', [
  'auth'
  'tab/home-controller'
  'tab/user-controller'
  'tab/user-detail-controller'
  'tab/about-controller'
], (auth) ->
  auth.config ['$routeProvider', ($routeProvider) ->
    # Home page.
    $routeProvider.when '/',
      templateUrl: 'base-auth/templates/home.html'
      controller: 'homeController'
    # User Master.
    $routeProvider.when '/user',
      templateUrl: 'base-auth/templates/user/master.html'
      controller: 'userController'
    # User Detail.
    $routeProvider.when '/user/:id',
      templateUrl: 'base-auth/templates/user/detail.html'
      controller: 'userDetailController'
    # About.
    $routeProvider.when '/about',
      templateUrl: 'base-auth/templates/about.html'
      controller: 'aboutController'
    # Invalid routes redirects to Home Page.
    $routeProvider.otherwise
      redirectTo: '/'
  ]