lyonjs = angular.module 'lyonjs'

lyonjs.controller 'MainCtrl', ($scope, Content) ->
  $scope.intro = Content.get
    key: 'intro'

  $scope.update = () ->
    $scope.intro.$save()
