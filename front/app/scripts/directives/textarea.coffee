lyonjs = angular.module 'lyonjs'

lyonjs.directive 'eipTextarea', ($timeout, $parse) ->
  restrict: 'A'
  require: '?ngModel'
  replace: true
  template: "
    <div>
      <div ng-show='!edit' ng-click='edit = true' ng-bind-html-unsafe='content'></div>
      <textarea ng-show='edit' ng-model='content'></textarea>
    </div>
  "
  scope:
    content: '=ngModel'
    #focusout: '='
  link: ($scope, $element, $attributes) ->
    console.log 'link', $scope

    $scope.edit = false

    textarea = $element.find 'textarea'

    textarea.bind 'focusout', () ->
      console.log 'focusout', $attributes
      $timeout () ->
        $scope.edit = false
      if $attributes.focusout?
        console.log 'invoker', $attributes.focusout
        invoker = $parse $attributes.focusout
        invoker $scope.$parent





