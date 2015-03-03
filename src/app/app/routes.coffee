# Define the routing.
define 'app/routes', [
  'app'
  # Individual tabs.
  'tab/home-controller'
  'tab/about-controller'
  # Users
  'users/list-ctrl'
  'users/detail-ctrl'
], (app) ->
  app.config [
    '$routeProvider'
    ($routeProvider) ->
      # Home page.
      $routeProvider.when '/',
        'templateUrl': 'templates/home.html'
        'controller': 'homeController'
      # User Master.
      $routeProvider.when '/users',
        'templateUrl': 'templates/users/master.html'
        'controller': 'usersListCtrl'
        'data':
          'label': 'Users'
          'selected': 'Users'
          'public': false
      # User Detail.
      $routeProvider.when '/users/:id',
        'templateUrl': 'templates/users/detail.html'
        'controller': 'usersDetailCtrl'
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
