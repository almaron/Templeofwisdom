@app.directive "fancybox", [() ->
  {
    restrict: "A",
    scope: {},
    link: (scope, element, attrs) ->
      angular.element(element).fancybox()
  }
]