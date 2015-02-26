# Define the routing.
define 'routes', [
  'tab/home-controller'
  'tab/user-controller'
  'tab/user-detail-controller'
  'tab/about-controller'
], (auth) ->
  auth.config ['$routeProvider', ($routeProvider) ->
    # Home page.
    $routeProvider.when '/',
      'templateUrl': 'templates/home.html'
      'controller': 'homeController'
      'data':
        'label': 'Home'
        'selected': 'Home'
        'public': true
    # User Master.
    $routeProvider.when '/user',
      'templateUrl': 'templates/user/master.html'
      'controller': 'userController'
      'data':
        'label': 'Users'
        'selected': 'Users'
        'public': false
    # User Detail.
    $routeProvider.when '/user/:id',
      'templateUrl': 'templates/user/detail.html'
      'controller': 'userDetailController'
      'data':
        'label': null
        'selected': 'Users'
        'public': false
    # About.
    $routeProvider.when '/about',
      'templateUrl': 'templates/about.html'
      'controller': 'aboutController'
      'data':
        'label': 'About'
        'selected': 'About'
        'public': true
    # Invalid routes redirects to Home Page.
    $routeProvider.otherwise
      'redirectTo': '/'
  ]