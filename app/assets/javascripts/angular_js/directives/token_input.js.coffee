@app.directive 'tokeninput', ['$timeout','$parse', ($timeout, $parse) ->
    {
      resrtict: 'A'
      replace: true
      scope:
        ngModel: '='
      link: (scope, element, attrs) ->
        options = scope.$eval(attrs.options) or {}

        apply = (results) ->
          scope.$apply ->
            scope.ngModel = $(element).tokenInput('get')

        options.theme = 'temple'
        options.onAdd = apply
        options.onDelete = apply
        options.prePopulate = scope.ngModel
        options.hintText = 'Введите тэг'
        options.searchingText = 'Поиск...'
        options.searchDelay = 20

        $(element).tokenInput attrs.href, options

    }
]