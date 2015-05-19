@app.directive 'tokeninput', ['$timeout','$parse', ($timeout, $parse) ->
    {
      resrtict: 'A'
      replace: true
      scope:
        ngModel: '='
        populate: '='
      link: (scope, element, attrs) ->
        options = scope.$eval(attrs.options) or {}

        apply = (results) ->
          tokens = $(element).tokenInput('get')
          scope.ngModel = tokens

        options.theme = 'temple'
        options.onAdd = apply
        options.onDelete = apply
        options.hintText = 'Введите тэг'
        options.searchingText = 'Поиск...'
        options.searchDelay = 20

        scope.$watchCollection 'populate', (newVal) ->
          if newVal
            $(element).tokenInput('clear')
            angular.forEach newVal, (tag, index) ->
              $(element).tokenInput("add", tag);

        $(element).tokenInput attrs.href, options

    }
]