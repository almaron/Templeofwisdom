@app.controller 'RolesCtrl', ['$scope', '$http', 'RolesService', 'ngTableParams', ($scope, $http, Service, ngTableParams) ->

  data = Service.cachedData

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      name: "asc"
  ,
    total: 0
    getData: ($defer, params) ->
      Service.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined(oldVal) && angular.isDefined(newVal)
    return

  $scope.showRole = (role) ->
    $http.get('/admin/roles/'+role.id+'.json').success (data) ->
      $scope.sRole = data.role

  $scope.removeRole = (role) ->
    $http.delete('/admin/roles/'+role.id+'.json').success () ->
      Service.reload $scope.tableParams



]