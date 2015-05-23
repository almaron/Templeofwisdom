@app.directive "fancybox", [() ->
  {
    restrict: "EA",
    scope: {},
    link: (scope, element, attrs) ->
        element.on 'click', (e) ->
          $.fancybox { href:attrs.href, parent: 'body', type: 'image'}
          e.preventDefault()
  }
]