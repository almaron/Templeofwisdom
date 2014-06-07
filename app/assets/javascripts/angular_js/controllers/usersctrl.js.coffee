@app.controller "UserCtrl",["$scope","User", ($scope, User)->

  $scope.initUsers = ->
    $scope.getUsers()

  $scope.getUsers = ->
    $scope.users = User.query({}, ->
      console.log $scope.users.length
    )


]