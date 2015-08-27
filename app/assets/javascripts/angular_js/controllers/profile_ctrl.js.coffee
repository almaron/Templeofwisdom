@app.controller "ProfileCtrl", ["$scope", "Profile",  "AdminUser", "Delegation", "$http", "$sce", "ArrayService", ($scope, Profile, User, Delegation, $http, $sce, ArrayService) ->

  $scope.allUsers = $scope.freeUsers = []

  $scope.loadProfile = ->
    data = Profile.get({}, () ->
      $scope.user = data.user
      $scope.authentications = data.authentications
      $scope.own_chars = data.own_chars
      $scope.delegated_chars = data.delegated_chars
    )
    $scope.getAllUsers()

  $scope.htmlEmbed = (embeded) ->
    $sce.trustAsHtml embeded

  $scope.getAllUsers = ->
    $http.get('/admin/users.json?scope=short').success (data) ->
      $scope.allUsers = data

  $scope.setDefaultChar = (char) ->
    if !char.default
      $http.put('/delegations/'+char.id+'.json').success (data) ->
        $scope.loadProfile()

  $scope.isDefault = (char) ->
    if char.default
      'fa-circle'
    else
      'fa-circle-thin'

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
        $scope.user = resp.user

  $scope.removeAuth = (provider) ->
    $http.delete(
        "/oauth/delete/"+provider+".json", {}
    ).success ->
      $scope.authentications.splice($scope.authentications.indexOf(provider),1)

  $scope.removeDelegation = (char, delegation) ->
    data = Delegation.delete({id:delegation.id}, ->
      char.delegated_to.splice(char.delegated_to.indexOf(delegation),1)
    )

  $scope.newDelegation = (char) ->
    ind = $scope.own_chars.indexOf(char)
    $scope.newChar = {char_id: char.id, name: char.name, char_index:ind, users:filterUsers($scope.allUsers, char)}
    $scope.modalShown = true

  $scope.delegateChar = (newChar) ->
    delegation = Delegation.save({char_delegation:newChar}, ->
      if delegation
        $scope.own_chars[newChar.char_index].delegated_to.push delegation
    )
    $scope.modalShown = false

  # Private methods

  filterUsers = (allUsers, char) ->
    freeUsers = angular.copy allUsers
    charUserIds = []
    angular.forEach char.delegated_to, (item, index) ->
      charUserIds.push(item.user_id)
    len = freeUsers.length
    while len--
      freeUsers.splice(len,1) if charUserIds.indexOf(allUsers[len].id) >= 0
    freeUsers
#    delegatedIndex = _.indexBy(char.delegated_to, 'user_id')
#    _.reject allUsers, (user) ->
#       user.id in delegatedIndex

]
