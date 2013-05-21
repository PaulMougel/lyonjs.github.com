lyonjs = angular.module 'lyonjs'

lyonjs.controller 'EventCtrl', ($scope, $routeParams, Event) ->
  $scope.event = Event.get $routeParams.id

  $scope.add = ->
    if !$scope.event.talks?
      $scope.event.talks = []
    $scope.event.talks.push {}