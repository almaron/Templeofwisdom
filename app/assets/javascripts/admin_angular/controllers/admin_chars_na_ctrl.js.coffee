@app.controller "AdminCharsNaCtrl", ['$scope', 'AdminChar', "ngTableFactory", "ngTableParams", ($scope, Char, Service, ngTableParams)->
  service = new Service('/admin/chars.json?scope=inactive')
  data = service.cachedData

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      name: "asc"
  ,
    total: 0
    getData: ($defer, params) ->
      service.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined(oldVal) && angular.isDefined(newVal)
    return

  $scope.$on 'reloadAllChars', () ->
    service.reload($scope.tableParams)

  $scope.$on 'reloadTable', () ->
    service.reload($scope.tableParams)
]
