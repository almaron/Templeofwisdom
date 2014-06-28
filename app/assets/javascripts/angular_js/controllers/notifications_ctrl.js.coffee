@app.controller 'NotificationsCtrl', ['$scope','$http','ngTableService', 'ngTableParams', ($scope, $http, Service, ngTableParams) ->

  data = Service.cachedData
  Service.setUrl '/notifications.json'

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
  ,
    total: 0
    getData: ($defer, params) ->
      Service.getData $defer, params, $scope.filter
      return
  )

  $scope.removeNote = (note) ->
    $http.delete('/notifications/'+note.id+'.json').success ->
      Service.reload($scope.tableParams)

  $scope.showNote = (note) ->
    $http.get('/notifications/'+note.id+'.json').success (data) ->
      Service.cachedData[Service.cachedData.indexOf(note)].read = true
      $scope.sNote = data

]