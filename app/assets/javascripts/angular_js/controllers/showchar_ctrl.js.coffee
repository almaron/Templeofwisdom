@app.controller "ShowCharCtrl", [ "$scope", "$http", "Char", ($scope, $http, Char) ->


  $scope.loadChar = (char_id) ->
    char = Char.get {id: char_id}, ->
      $scope.char = char
      $scope.smallUpdatePath = "/chars/"+char.id+"/small_update.json"

  $scope.openEditChar = (page) ->
    $scope.editChar = page || "points"
    $scope.editForm = {
      sign: 1,
      person: $scope.char.profile.person,
      comment: $scope.char.profile.comment
      signature: $scope.char.signature
    }

  $scope.updatePoints = ->
    value = $scope.editForm.value * $scope.editForm.sign
    $http.post(
      $scope.smallUpdatePath, {field:"points", value:value}
    ).success (data) ->
      $scope.char.profile.points = data.value
      $scope.editForm = {}
      $scope.editChar = null

  $scope.updatePerson = ->
    $http.post(
      $scope.smallUpdatePath, {field:"person", person:$scope.editForm.person}
    ).success (data) ->
      $scope.char.profile.person = data.value
      $scope.editForm = {}
      $scope.editChar = null

  $scope.updateComment = ->
    $http.post(
      $scope.smallUpdatePath, {field:"comment", comment:$scope.editForm.comment}
    ).success (data) ->
      $scope.char.profile.comment = data.value
      $scope.editForm = {}
      $scope.editChar = null

  $scope.updateSignature = ->
    $http.post(
      $scope.smallUpdatePath, {field:"signature", signature:$scope.editForm.signature}
    ).success (data) ->
      $scope.char.signature = data.value
      $scope.char.signature_show = data.html_value
      $scope.editForm = {}
      $scope.editChar = null

  $scope.editSkills = (skill_type) ->
    if skill_type == 'phisic'
      $scope.skillForm = {head: "Навыки"}
      $scope.skillForm.skills = $scope.char.phisic_skills
    else
      $scope.skillForm = {head: "Способности"}
      $scope.skillForm.skills = $scope.char.magic_skills
    $http.get('/skills/'+skill_type+'.json?char_id='+$scope.char.id).success (data) ->
      $scope.skillForm.addSkills = data
      $scope.editChar = 'skills'

  $scope.addSkill = ->
    $scope.upSkill $scope.skillForm.addSkill if $scope.skillForm.addSkill

  showMessage = ->
    if $(document).scrollTop() > 250
      $(document).scrollTop 200
    $scope.editChar = false

  $scope.upSkill = (skill_id) ->
    $http.post('/chars/'+$scope.char.id+'/request_skill/'+skill_id+'.json').success(
      (data) ->
        $scope.flashMessage data.success
        showMessage()
    ).error(
      (data) ->
        $scope.flashMessage data.failure, 'alert'
        showMessage()
    )
]