lyonjs = angular.module 'lyonjs'

lyonjs.service 'Event', ->
  query: ->
    [
      id: 1
      date: new Date 2013, 4, 14
      title: 'Comparaison frameworks JS MVC'
    ,
      id: 2
      date: new Date 2013, 3, 9
      title: 'CozyCloud'
    ,
      id: 3
      date: new Date 2013, 5, 4
      title: 'Windows 8'
    ]

lyonjs.controller 'EventsCtrl', ($scope, Event) ->
  $scope.events = do Event.query
