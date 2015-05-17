@app.controller "CharFormCtrl", ["$scope", "$http", "Char", "ArrayService", ($scope, $http, Char, ArrayService) ->

  $scope.formInit = (char_id = null) ->
    $scope.loadChar(char_id)
    $scope.loadSkills()
    $scope.newCharSkill = {level_id:1}

  $scope.loadChar = (char_id = null) ->
    if char_id
      $scope.char = Char.get({id: char_id, short:true})
    else
      $scope.char = {group_id:2, magic_skills:[],phisic_skills:[], profile_attributes: {}}

  $scope.loadSkills = ->
    $http.get(
      "/chars/engine.json", {}
    ).success((data) ->
      $scope.phisicSkills = data.phisic_skills
      $scope.magicSkills = data.magic_skills
      $scope.levels = data.levels
      $scope.acessibleGroups = data.accessible_groups
    )

  $scope.addPhisicSkill = (char_skill) ->
    unless ArrayService.findBy($scope.char.phisic_skills, "skill_id", char_skill.skill_id) || !char_skill.skill_id
      new_char_skill = {
        skill_id: char_skill.skill_id,
        skill_name: ArrayService.findBy($scope.phisicSkills, "id", char_skill.skill_id).name,
        level_id: char_skill.level_id,
        level_name: ArrayService.findBy($scope.levels, "id", char_skill.level_id).name
      }
      $scope.char.phisic_skills.push(new_char_skill)
      $scope.newCharSkill = {level_id:1}

  $scope.addMagicSkill = (char_skill) ->
    unless ArrayService.findBy($scope.char.magic_skills, "skill_id", char_skill.skill_id) || !char_skill.skill_id
      new_char_skill = {
        skill_id: char_skill.skill_id,
        skill_name: ArrayService.findBy($scope.magicSkills, "id", char_skill.skill_id).name,
        level_id: char_skill.level_id,
        level_name: ArrayService.findBy($scope.levels, "id", char_skill.level_id).name
      }
      $scope.char.magic_skills.push(new_char_skill)
      $scope.newCharSkill = {level_id:1}

  $scope.removeSkill = (skill_set, char_skill) ->
    skill_set.splice(skill_set.indexOf(char_skill),1)

  $scope.changeSeasonId = ->
    strip = $scope.char.profile_attributes.birth_date.split(".")
    if strip.length > 1 && parseInt(strip[1]) > 0
      month = parseInt(strip[1])
      if month < 3 || month == 12
        season = 1
      else if month < 6
        season = 2
      else if month < 9
        season = 3
      else
        season = 4
    $scope.char.profile_attributes.season_id = season

]