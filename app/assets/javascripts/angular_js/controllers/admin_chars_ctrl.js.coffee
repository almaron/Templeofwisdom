@app.controller "AdminCharsCtrl", ['$scope', '$http', 'AdminChar', "CharsService", "ngTableParams", ($scope, $http, Char, CharsService, ngTableParams)->

  data = CharsService.cachedData
  $scope.chars = []
  $scope.showedChar = {}
  $scope.editedChar = {}

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      name: "asc"
  ,
    total: 0
    getData: ($defer, params) ->
      CharsService.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined(oldVal) && angular.isDefined(newVal)
    return

  $scope.showChar = (char) ->
    $scope.sChar = angular.copy(char)

  $scope.removeChar = (char) ->
    if confirm("Точно удалить?")
      Char.delete({id:char.id}, ->
        CharsService.reload($scope.tableParams)
        $scope.loadBlock 'reviewed'
      )

  $scope.loadBlock = (scope) ->
    $scope.chars[scope] = Char.query {scope: scope}

  $scope.loadChars = () ->
    $scope.loadBlock 'pending'
    $scope.loadBlock 'reviewed'
    $scope.loadBlock 'saved'
    $('.admin-wrapper').removeClass('hide')

  $scope.acceptChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/accept.json', {accept_char_id: char.id}).success (data) ->
      $scope.loadBlock 'pending'
      $scope.loadBlock 'reviewed'

  $scope.approveChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/approve.json', {approve_char_id: char.id}).success (data) ->
      $scope.loadBlock 'reviewed'
      CharsService.reload($scope.tableParams)

  $scope.declineChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/decline.json', {approve_char_id: char.id}).success (data) ->
      $scope.loadBlock 'pending'

  $scope.showFull = (char) ->
    $scope.showedChar = Char.get {id:char.id}

  $scope.editChar = (char) ->
    $scope.editedChar = Char.get {id:char.id}

  $scope.closeModal = ->
    $scope.editedChar = {}
    $scope.showedChar = {}


  $scope.updateChar = () ->
    $scope.editedChar.char_skills_attributes = $scope.editedChar.magic_skills.concat $scope.editedChar.phisic_skills
    $scope.editedChar.phisic_skills = $scope.editedChar.magic_skills = null
    Char.update({id:$scope.editedChar.id, char:$scope.editedChar}, ->
      CharsService.reload $scope.tableParams
      $scope.loadBlock 'reviewed'
      $scope.editedChar = {}
    )

]