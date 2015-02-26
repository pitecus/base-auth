#
# Setup RequireJS dependencies.
#
require.config
  paths:
    'angular':       '../../../static/angular-1.2.25/js/angular.min'
    'angular-route': '../../../static/angular-1.2.25/js/angular-route.min'
    'angular-bootstrap': [
      '../../../static/angular-bootstrap-0.11.0/js/ui-bootstrap.min'
      '../../../static/angular-bootstrap-0.11.0/js/ui-bootstrap-tpls.min'
    ]
  shim:
    'angular':
      exports: 'angular'
    'angular-route':
      exports: 'angular-route'
      deps: ['angular']
    'angular-bootstrap':
      exports: 'angular-bootstrap'
      deps: ['angular']

# http://code.angularjs.org/1.2.1/docs/guide/bootstrap#overview_deferred-bootstrap
window.name = 'NG_DEFER_BOOTSTRAP!'

# Bootstrap the app.
require ['angular', 'app', 'routes'], (angular, app, routes) ->
  $html = angular.element document.getElementsByTagName('html')[0]

  angular.element().ready ->
    angular.resumeBootstrap [app['name']]