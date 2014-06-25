@app.controller 'RoleAppsCtrl', ['$scope', '$http', ($scope, $http) ->

  $http.get('/role_apps.json').success (data)->
    $scope.roleApps = data

  $scope.editApp = (role_app) ->
    $scope.sApp = angular.copy role_app

  $scope.closeEdit = ->
    $scope.sApp = {}
    $scope.newFormShow = false

  $scope.createApp = ->
    $http.post(
      '/role_apps.json',
      {role_app:$scope.sApp}
    ).success(
      (data)->
        $scope.roleApps.push data
        $scope.closeEdit()
    ).error( (data) ->
      $scope.sApp.errors = data.errors
    )

  $scope.updateApp = (role_app) ->
    $http.put(
      '/role_apps/'+role_app.id+'.json',
      {role_app:$scope.sApp}
    ).success(
      (data)->
        $scope.roleApps[$scope.roleApps.indexOf(role_app)] = data
        $scope.closeEdit()
    ).error( (data) ->
      $scope.sApp.errors = data.errors
    )

  $scope.removeApp = (role_app) ->
    $http.delete('/role_apps/'+role_app+'.json').success ->
      $scope.roleApps.splice($scope.roleApps.indexOf(role_app),1)
]