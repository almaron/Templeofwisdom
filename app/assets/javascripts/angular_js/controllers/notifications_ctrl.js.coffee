@app.controller 'NotificationsCtrl', ['$scope','$http','NoteService', 'ngTableParams', ($scope, $http, NoteService, ngTableParams) ->

  data = NoteService.cachedData

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
  ,
    total: 0
    getData: ($defer, params) ->
      NoteService.getData $defer, params, $scope.filter
      return
  )

  $scope.removeNote = (note) ->
    NoteService.removeNote(note, $scope.tableParams)

  $scope.showNote = (note) ->
    $http.get('/notifications/'+note.id+'.json').success (data) ->
      $scope.sNote = data
      NoteService.readNote note
]