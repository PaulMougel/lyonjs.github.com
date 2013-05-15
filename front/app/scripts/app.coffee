lyonjs = angular.module 'lyonjs', ['ngResource']

lyonjs.config ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: 'views/main.html'
    controller: 'MainCtrl'
  $routeProvider.when '/profile',
    templateUrl: 'views/profile.html'
    controller: 'ProfileCtrl'
  $routeProvider.when '/events',
    templateUrl: 'views/events.html'
    controller: 'EventsCtrl'
  $routeProvider.when '/events/:id',
    templateUrl: 'views/event.html'
    controller: 'EventCtrl'
  $routeProvider.otherwise
    redirectTo: '/'

lyonjs.value 'ServerURL', 'http://localhost\\:1234/api'

lyonjs.factory 'User', ($resource, ServerURL) ->
  $resource "#{ServerURL}/user", {},
    query:
      method: 'GET'

lyonjs.factory 'Content', ($resource, ServerURL) ->
  $resource "#{ServerURL}/content/:key",
    key: '@key'