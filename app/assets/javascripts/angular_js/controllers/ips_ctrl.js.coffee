@app.controller "IpsCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.ipPage = {cur:1}
  $scope.all_users = []
  $scope.users = []
  per_page = 20

  $http.get('/admin/ips.json').success (data) ->
    $scope.ipPage.total = Math.ceil(data.length / per_page)
    $scope.all_users = $scope.users = data
    $scope.data = data.slice(0,per_page)

  $scope.count = 0

  $scope.setPage = (page) ->
    start = (page-1)*per_page
    end = page*per_page
    console.log(page)
    $scope.data = $scope.users.slice(start,end)

  $scope.filterUsers = (search) ->
    data = []
    $scope.ipPage.cur = 1
    if (search == '')
      $scope.users = $scope.all_users;
    else
      angular.forEach $scope.all_users, (user, index) ->
        keep = true
        if user.name.indexOf(search) >=0
          data.push user
        else
          angular.forEach user.ips, (ip, ipIndex) ->
            if keep && ip.indexOf(search)>=0
              data.push user
              keep = false
      $scope.users = data;
    $scope.setPage(1)

  $scope.markActive = (ofstring, substring) ->
    ofstring.indexOf(substring) >= 0 && substring!=''

  $scope.selectIp = (ip)->
    $scope.userSearch = ip
    $scope.filterUsers ip
]