@app.controller "UserCtrl",["$scope", "$http", "$filter", "ngTableService", 'AdminUser', "ngTableParams", ($scope, $http, $filter, Service, User, ngTableParams)->

  data = Service.cachedData
  Service.setUrl '/admin/users.json'

  $scope.destroyedUsers = User.query({scope:"destroyed"})
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
      Service.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined newVal
    return

  $scope.editUser = (user) ->
    angular.copy user, $scope.selectedUser

  $scope.resetUser =  ->
    user = $filter('filter')(data, {id: $scope.selectedUser.id})
    $scope.editUser user[0]

  $scope.updateUser = ->
    $scope.selectedUser = User.update {id:$scope.selectedUser.id, user:$scope.selectedUser}, ->
      Service.reload($scope.tableParams)

  $scope.removeUser = (user) ->
    User.delete {id:user.id}, ->
      Service.reload($scope.tableParams)
    $scope.destroyedUsers.push user




]