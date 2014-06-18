@app.controller "UserCtrl",["$scope", "$http", "$filter", "UsersService", "ngTableParams", ($scope, $http, $filter, UsersService, ngTableParams)->

  data = UsersService.cachedData

  $scope.destroyedUsers = UsersService.destroyedUsers()
  $scope.selectedUser = {}

  $http.get("/user_groups.json").success (data) ->
    $scope.userGroups = data

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      name: "asc"
  ,
    total: 0 # length of data
    getData: ($defer, params) ->
      UsersService.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if (typeof oldVal != "undefined") && (typeof newVal != "undefined")
    return

  $scope.editUser = (user) ->
    angular.copy user, $scope.selectedUser

  $scope.resetUser =  ->
    user = $filter('filter')(data, {id: $scope.selectedUser.id})
    $scope.editUser user[0]

  $scope.updateUser = ->
    $scope.selectedUser = UsersService.updateUser($scope.selectedUser, $scope.tableParams)

  $scope.removeUser = (user) ->
    UsersService.removeUser(user,$scope.tableParams)
    $scope.destroyedUsers.push user




]