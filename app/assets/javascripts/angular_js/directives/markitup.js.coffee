@app.directive "markItUp", ["markitupSettings", (markitupSettings) ->
  {
    restrict: "A",
    scope: {
      ngModel: "="
    },
    link: (scope, element, attrs) ->
      settings = markitupSettings.create (event) ->
        scope.$apply () ->
          scope.ngModel = event.textarea.value
      angular.element(element).markItUp(settings)
  }
]