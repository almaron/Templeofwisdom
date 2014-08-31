@app.controller "IpsCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.ipPage = {cur:1}
  all_users = []
  users = []

  $http.get('/admin/ips.json').success (data) ->
    $scope.ipPage.total = Math.ceil(data.length / 20.0)
    all_users = users = data
    $scope.users = data.slice(0,19)

  $scope.count = 0

  $scope.setPage = ->
    $scope.users = users.slice(($scope.ipPage.cur-1)*20,($scope.ipPage.cur*20 - 1))

  $scope.filterUsers = (search) ->
    data = []
    $scope.ipPage.cur = 1
    if (search == '')
      users = all_users;
    else
      angular.forEach all_users, (user, index) ->
        keep = true
        if user.name.indexOf(search) >=0
          data.push user
        else
          angular.forEach user.ips, (ip, ipIndex) ->
            if keep && ip.indexOf(search)>=0
              data.push user
              keep = false
      users = data;
    $scope.setPage()

  $scope.markActive = (ofstring, substring) ->
    ofstring.indexOf(substring) >= 0 && substring!=''

  $scope.selectIp = (ip)->
    $scope.userSearch = ip
    $scope.filterUsers ip
]