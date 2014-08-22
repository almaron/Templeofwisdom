@app.controller 'SkillsCtrl', ["$http", "$scope", "$location", "$anchorScroll", "$filter", ($http, $scope, $location, $anchorScroll, $filter) ->

  $http.get('/admin/skills.json').success (data) ->
    $scope.skills = data
  $scope.editedSkill = {}
  $scope.newSkill = {skill_type:'phisic'}

  $scope.editSkill = (skill) ->
    $http.get('/skills/'+skill.id+'.json').success (data) ->
      $scope.editedSkill = data
      $scope.editedSkill.discount_array = []
      if data.discount
        arr = data.discount.split(',')
        angular.forEach arr, (str) ->
          $scope.editedSkill.discount_array.push parseInt(str)
      $location.hash 'head'
      $anchorScroll()

  $scope.closeEdit = ->
    $scope.editedSkill = {}

  $scope.addSkill = ->
    $http.post('/admin/skills.json', {skill_name: $scope.newSkill.name, skill_type: $scope.newSkill.skill_type }).success (data) ->
      $scope.skills.push data
    $scope.newSkill = {skill_type:'phisic'}

  $scope.updateSkill = ->
    $scope.editedSkill.discount = $scope.editedSkill.discount_array.join(',')
    $scope.editedSkill.skill_levels_attributes = $scope.editedSkill.skill_levels
    $scope.editedSkill.skill_levels = null
    $http.put(
      '/admin/skills/'+$scope.editedSkill.id+'.json',
      {skill:$scope.editedSkill}
    ).success(
      (data) ->
        skill = $filter('filter')(
          $scope.skills,
          (d) ->
            d.id == data.id
        )[0]
        skill.name = data.name
        $scope.editedSkill = {}
    )

  $scope.deleteSkill = (skill) ->
    $http.delete('/admin/skills/'+skill.id+'.json').success (data) ->
      $scope.skills.splice($scope.skills.indexOf(skill),1)

]