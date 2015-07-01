@app.controller 'QuestionCtrl', ['$scope','$http', ($scope, $http) ->
  $scope.setQ = (id) ->
    $scope.qId = id
    $http.get('/questions/'+id+'/answers.json').success (data)->
      $scope.answers = data
    $scope.cAn = {}


  $scope.editAnswer = (answer) ->
    $scope.cAn = angular.copy answer

  $scope.closeEdit = ->
    $scope.cAn = {}

  $scope.updateAnswer = () ->
    $http.put('/questions/'+$scope.qId+'/answers/'+$scope.cAn.id+'.json', { master_answer: $scope.cAn }).success (data) ->
      $scope.setQ($scope.qId)
      $scope.cAn = {}
]
