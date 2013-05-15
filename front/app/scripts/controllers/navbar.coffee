lyonjs = angular.module 'lyonjs'

lyonjs.controller 'navbar', ($scope, User) ->
  ## Works only with a hack on ngResource for adding $http withCredentials
  $scope.user = do User.query

  $scope.login = ->
    location.href = 'http://localhost:1234/auth/twitter'