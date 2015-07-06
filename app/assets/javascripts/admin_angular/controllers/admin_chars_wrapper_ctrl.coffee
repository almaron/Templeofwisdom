@app.controller 'AdminCharsWrapperCtrl', ['$scope', '$http', 'AdminChar', ($scope, $http, Char) ->
  $scope.showedChar = {}
  $scope.sChar = {}
  $scope.editedChar = {}

  $scope.showChar = (char) ->
    $scope.sChar = angular.copy(char)

  $scope.removeChar = (char) ->
    if confirm("Точно удалить?")
      Char.delete({id:char.id}, ->
        $scope.$broadcast 'reloadAllChars'
      )

  $scope.restoreChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/restore.json', {}).success (data) ->
      $scope.$broadcast 'reloadTable'

  $scope.editChar = (char) ->
    $scope.editedChar = Char.get {id:char.id}

  $scope.closeModal = ->
    $scope.editedChar = {}
    $scope.showedChar = {}


  $scope.updateChar = () ->
    $scope.editedChar.char_skills_attributes = $scope.editedChar.magic_skills.concat $scope.editedChar.phisic_skills
    $scope.editedChar.phisic_skills = $scope.editedChar.magic_skills = null
    Char.update({id:$scope.editedChar.id, char:$scope.editedChar}, ->
      $scope.$broadcast 'reloadAllChars'
      $scope.editedChar = {}
    )


]
