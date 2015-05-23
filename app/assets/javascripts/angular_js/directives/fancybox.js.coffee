@app.directive "fancybox", [() ->
  {
    restrict: "EA",
    scope: {},
    link: (scope, element, attrs) ->
      element.on 'click', (e) ->
        $.fancybox attrs.href
        e.preventDefault()
  }
]