# Navigation Bar Controller.
define 'navbar/ctrl', [
  'app'
  'app/auth-factory'
], (app) ->
  app.controller 'navbarCtrl', [
    '$scope'
    '$location'
    '$route'
    'appAuthFactory'
    ($scope, $location, $route, appAuthFactory) ->
      # Routes available.
      $scope.routes = []

      # User display.
      $scope.displayName = ''

      # Highlight the selected tab.
      $scope.navClass = (page) ->
        active = $location.path().indexOf page
        return if active == 0 then 'active' else ''

      # If is authenticated.
      appAuthFactory.isAuthenticated()
      .then (user) ->
        # Load all routes.
        $scope.routes = []
        for k, v of $route.routes
          if v.data? and v.data.label? then $scope.routes.push
            'data': v.data
            'path': k

        # Update the display name.
        $scope.displayName = user.displayName
      , (error) ->
        # Load public routes.
        for k, v of $route.routes
          if v.data? and v.data.label? and v.data.public then $scope.routes.push
            'data': v.data
            'path': k
  ]
