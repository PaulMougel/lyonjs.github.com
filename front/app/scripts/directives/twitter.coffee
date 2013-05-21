lyonjs = angular.module 'lyonjs'

lyonjs.directive 'eipTwitter', ($timeout, $parse, User) ->
  restrict: 'E'
  require: '?ngModel'
  replace: true
  transclude: true
  template: "
    <div>
      <div ng-show='!edit' ng-click='edit = true'></div>
      <input type='text' ng-show='edit' ng-model='screen_name'></textarea>
    </div>
  "
  scope:
    screen_name: '=ngModel'
  compile: ($element, $attributes, $transclude) ->
    ($scope, $element, $attributes) ->
      $scope.edit = false

      input = $element.find 'input'

      input.bind 'focusout', ->
        $timeout ->
          $scope.edit = false
        User.get {twitter: input.val()}, (data) ->
          $timeout ->
            $scope.twitter = data

        if $attributes.focusout?
          console.log 'invoker', $attributes.focusout
          invoker = $parse $attributes.focusout
          invoker $scope.$parent

      # Hand made transclusion in order to attach to directive's scope
      $transclude $scope, (clone) ->
        $element.find('div').append clone
