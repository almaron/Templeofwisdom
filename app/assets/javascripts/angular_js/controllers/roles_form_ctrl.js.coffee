@app.controller 'RolesFormCtrl', ['$scope', '$http', '$window', ($scope, $http, $window) ->

  $scope.loadRole = (role_id = null) ->
    $http.get('/admin/roles/'+role_id+'.json').success (data) ->
      $scope.role = data.role

  $scope.initRole = (app_id = 0) ->
    if app_id > 0
      url = '?role_app_id?='+app_id
    else
      url = ''
    $http.get('/admin/roles/new.json'+url).success (data) ->
      $scope.role = data.role

  $http.get('/admin/roles/new.json?get_chars=true').success (data) ->
    $scope.allChars = data.chars
    $scope.skills = data.skills

  $scope.createRole = () ->
    $http.post(
      '/admin/roles.json',
      {role:$scope.role}
    ).success( (data)->
      $window.location.assign(data.redirect)
    ).error( (data)->
      $scope.errors = data.errors
    )

  $scope.updateRole = () ->
    $http.put(
      '/admin/roles/'+$scope.role.id+'.json',
      {role:$scope.role}
    ).success( (data)->
      $window.location.assign(data.redirect)
    ).error( (data)->
      $scope.errors = data.errors
    )

  $scope.addCharRole = (char) ->
    if angular.isDefined(char) && char.id
      found = false
      angular.forEach $scope.role.char_roles_attributes, (char_role) ->
        if !found && char_role.char_id == char.id
          found = true
          char_role._destroy = 0
          return
      if !found
        $scope.role.char_roles_attributes.push {char_id:char.id, char_name:char.name, logic_points:10, style_points:10, skill_points:10, volume_points:10, role_skills_attributes:[], _destroy:0}

  $scope.addRoleSkill = (char_role, skill) ->
    if angular.isDefined(skill) && skill.id
      found = false
      console.log 'skill.id = '+skill.id
      angular.forEach char_role.role_skills_attributes, (role_skill) ->
        if !found && role_skill.skill_id == skill.id
          found = true
          console.log 'found'
          role_skill._destroy = 0
          return
      if !found
        char_role.role_skills_attributes.push { skill_id:skill.id, done:0, skill_name: skill.name, _destroy:0 }

  $scope.removeCharRole = (char_role) ->
    if char_role.id
      char_role._destroy = 1
    else
      $scope.role.char_roles_attributes.splice($scope.role.char_roles_attributes.indexOf(char_role),1)

  $scope.removeRoleSkill = (char_role, role_skill) ->
    if role_skill.id
      role_skill._destroy = 1
    else
      char_role.role_skills_attributes.splice(char_role.role_skills_attributes.indexOf(role_skill), 1)

  $scope.setDone = (role_skill) ->
    if role_skill.done > 0
      role_skill.done = 0
    else
      role_skill.done = 1

]