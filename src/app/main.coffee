#
# Setup RequireJS dependencies.
#
require.config
  # Using relative path instead of absolute.
  'paths':
    'angular':                '../../../static/angular-1.2.25/js/angular.min'
    'angular-cookies':        '../../../static/angular-1.2.25/js/angular-cookies.min'
    'angular-route':          '../../../static/angular-1.2.25/js/angular-route.min'
    'angular-bootstrap':      '../../../static/angular-bootstrap-0.11.0/js/ui-bootstrap.min'
    'angular-bootstrap-tpls': '../../../static/angular-bootstrap-0.11.0/js/ui-bootstrap-tpls.min'
  'shim':
    'angular':
      'exports': 'angular'
    'angular-cookies':
      'exports': 'angular-cookies'
      'deps': [
        'angular'
      ]
    'angular-route':
      'exports': 'angular-route'
      'deps': [
        'angular'
      ]
    'angular-bootstrap':
      'exports': 'angular-bootstrap'
      'deps': [
        'angular'
      ]
    'angular-bootstrap-tpls':
      'exports': 'angular-bootstrap-tpls'
      'deps': [
        'angular-bootstrap'
      ]

#
# http://code.angularjs.org/1.2.25/docs/guide/bootstrap#overview_deferred-bootstrap
window.name = 'NG_DEFER_BOOTSTRAP!'

# Bootstrap the app.
require [
  # Angular library.
  'angular'
  # Application module.
  'app'
  # Startup scripts.
  #'app/run'
  # Routing.
  'app/routes'
  # Navigation bar.
  'navbar/directive'
  'navbar/ctrl'
], (angular) ->
  #$html = angular.element document.getElementsByTagName('html')[0]

  angular.element().ready ->
    angular.resumeBootstrap ['app']
