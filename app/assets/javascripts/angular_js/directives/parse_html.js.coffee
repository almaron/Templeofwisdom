@app.directive 'parseHtml', [ '$compile', ($compile) ->
  {
    restrict: 'A'
    replace: true,
    scope:
      parseHtml: '&'
    link: (scope, element, attrs) ->
      scope.$watch 'parseHtml', (html)->
        element.html html
        $compile(element.contents())(scope)
  }
]