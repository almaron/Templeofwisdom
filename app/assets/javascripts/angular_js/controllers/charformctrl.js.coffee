@app.controller "CharFormCtrl", ["$scope", "$http", "Char", ($scope, $http, Char) ->

  $scope.formInit = (char_id = null) ->
    if char_id
      $scope.char = Char.get({id: char_id})
    $scope.loadSkills()

  $scope.loadSkills = ->
    $http.get(
      "/chars_engine.json", {}
    ).success((data) ->
      $scope.phisicSkills = data.phisic_skills
      $scope.magicSkills = data.magic_skills
      $scope.acessibleGroups = data.accessible_groups
    )
]