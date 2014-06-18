@app.controller "AdminCharsCtrl", ['$scope', 'AdminChar', "CharsService", "ngTableParams", ($scope, Char, CharsService, ngTableParams)->

  data = CharsService.cachedData

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      name: "asc"
  ,
    total: 0
    getData: ($defer, params) ->
      CharsService.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined(oldVal) && angular.isDefined(newVal)
    return

  $scope.showChar = (char) ->
    $scope.sChar = angular.copy(char)

  $scope.removeChar = (char) ->
    if confirm("Точно удалить?")
      Char.delete({id:char.id}, ->
        CharsService.reload($scope.tableParams)
      )

  $scope.loadBlock = (scope) ->
    return Char.query {scope: scope}

  $scope.loadChars = () ->
    $scope.pendingChars = $scope.loadBlock 'pending'
    $scope.reviedChars = $scope.loadBlock 'on_review'
]