@app.controller "CharFormCtrl", ["$scope", "$http", "Char", ($scope, $http, Char) ->

  $scope.formInit = (char_id = null) ->
    if char_id
      $scope.char = Char.get({id: char_id})
    $http.get(
      "/chars_engine.json", {}
    ).success((data) ->
      $scope.phisic_skills = data.phisic_skills
      $scope.magic_skills = data.magic_skills
    )

  $scope.loadSkills = ->



]