# Check if the user is logged or not.
define 'users/service', [
  'app'
], (app) ->
  # Load application.
  app.factory 'usersService', [
    '$http'
    ($http) ->
      URL = 'api/v1/users/'

      # List.
      list: ->
        $http
          'method': 'GET'
          'url': URL

      # Create.
      create: (queryId) ->
        $http
          'method': 'POST'
          'url': URL
          'data':
            'queryId': queryId

      # Retrieve.
      get: (id) ->
        $http
          'method': 'GET'
          'url': URL + id

      # Update.
      update: (id, title, query) ->
        $http
          'method': 'PUT'
          'url': URL + id
          'data':
            'title': title
            'query': query

      # Delete.
      delete: (id) ->
        $http
          'method': 'DELETE'
          'url': URL + id
  ]

  # Return.
  app
