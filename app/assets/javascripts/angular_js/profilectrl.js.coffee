@app.controller "ProfileCtrl", ["$scope", "Profile", "$http", ($scope, Profile, $http) ->

  $scope.loadProfile = ->
    $scope.user = Profile.get()
    $scope.setProviders()

  $scope.setProviders = ->
    $scope.authProviders = [
      {name:"ВКонтакте", provider:"vk"},
      {name:"Facebook", provider:"facebook"},
      {name:"GMail", provider:"google"},
      {name:"Twitter", provider:"twitter"}
    ]

  $scope.updateProfile = ->
    $scope.user.errors = null
    resp = Profile.update {user:$scope.user}, () ->
      if resp.errors
        $scope.user.errors = resp.errors
      else
        $scope.user.password = null
        $scope.user.password_confirmation = null
        $scope.user.editProfile = false

  $scope.removeAuth = (provider) ->
    $http.delete(
        "/oauth/delete/"+provider+".json", {}
    ).success ->
      $scope.user.authentications.splice($scope.user.authentications.indexOf(provider),1)
]