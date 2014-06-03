@app.controller "CharFormCtrl", ["$scope", "$http", "Char", "ArrayService", ($scope, $http, Char, ArrayService) ->

  $scope.formInit = (char_id = null) ->
    $scope.loadChar(char_id)
    $scope.loadSkills()
    $scope.newCharSkill = {level_id:1}

  $scope.loadChar = (char_id = null) ->
    if char_id
      $scope.char = Char.get({id: char_id})
    else
      $scope.char = {group_id:2, magic_skills:[],phisic_skills:[]}

  $scope.loadSkills = ->
    $http.get(
      "/chars_engine.json", {}
    ).success((data) ->
      $scope.phisicSkills = data.phisic_skills
      $scope.magicSkills = data.magic_skills
      $scope.levels = data.levels
      $scope.acessibleGroups = data.accessible_groups
    )

  $scope.addPhisicSkill = (char_skill) ->
    unless ArrayService.findInArrayBy($scope.char.phisic_skills, "skill_id", char_skill.skill_id) || !char_skill.skill_id
      new_char_skill = {
        skill_id: char_skill.skill_id,
        skill_name: ArrayService.findInArrayBy($scope.phisicSkills, "id", char_skill.skill_id).name,
        level_id: char_skill.level_id,
        level_name: ArrayService.findInArrayBy($scope.levels, "id", char_skill.level_id).name
      }
      $scope.char.phisic_skills.push(new_char_skill)
      $scope.newCharSkill = {level_id:1}

  $scope.addMagicSkill = (char_skill) ->
    unless ArrayService.findInArrayBy($scope.char.magic_skills, "skill_id", char_skill.skill_id) || !char_skill.skill_id
      new_char_skill = {
        skill_id: char_skill.skill_id,
        skill_name: ArrayService.findInArrayBy($scope.magicSkills, "id", char_skill.skill_id).name,
        level_id: char_skill.level_id,
        level_name: ArrayService.findInArrayBy($scope.levels, "id", char_skill.level_id).name
      }
      $scope.char.magic_skills.push(new_char_skill)
      $scope.newCharSkill = {level_id:1}

  $scope.removeSkill = (skill_set, char_skill) ->
    skill_set.splice(skill_set.indexOf(char_skill),1)
]