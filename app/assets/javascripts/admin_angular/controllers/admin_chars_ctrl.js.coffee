@app.controller "AdminCharsCtrl", ['$scope', '$http', 'AdminChar', "ngTableFactory", "ngTableParams", ($scope, $http, Char, Service, ngTableParams)->

  service = new Service('/admin/chars.json')
  data = service.cachedData
  $scope.chars = []

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      name: "asc"
  ,
    total: 0
    getData: ($defer, params) ->
      service.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined(oldVal) && angular.isDefined(newVal)
    return


  $scope.$on 'reloadAllChars', () ->
    service.reload($scope.tableParams)
    $scope.loadBlock 'reviewed'

  $scope.$on 'reloadTable', () ->
    service.reload($scope.tableParams)

  $scope.restoreChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/restore.json', {}).success (data) ->
      service.reload($scope.tableParams)

  $scope.loadBlock = (scope) ->
    $scope.chars[scope] = Char.query {scope: scope}

  $scope.loadChars = () ->
    $scope.loadBlock 'pending'
    $scope.loadBlock 'reviewed'
    $scope.loadBlock 'saved'
    $scope.showAll = true

  $scope.acceptChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/accept.json', {accept_char_id: char.id}).success (data) ->
      $scope.loadBlock 'pending'
      $scope.loadBlock 'reviewed'

  $scope.approveChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/approve.json', {approve_char_id: char.id}).success (data) ->
      $scope.loadBlock 'reviewed'
      service.reload($scope.tableParams)

  $scope.declineChar = (char) ->
    $http.put('/admin/chars/'+char.id+'/decline.json', {approve_char_id: char.id}).success (data) ->
      $scope.loadBlock 'pending'

  $scope.showFull = (char) ->
    $scope.showedChar = Char.get {id:char.id}


]
