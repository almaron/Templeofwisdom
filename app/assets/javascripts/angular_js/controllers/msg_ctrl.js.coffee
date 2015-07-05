@app.controller 'MsgCtrl', [ '$scope', '$http', 'ngTableService', 'ngTableParams', ($scope, $http, Service, ngTableParams) ->

  data = Service.cachedData

  $scope.set_service_url = (url) ->
    Service.setUrl url

  $http.get('/admin/chars.json?scope=messagable&short=true').success (data) ->
    $scope.allChars = data

  $scope.set_service_url '/messages.json'

  $scope.showOutbox = $scope.showNew = false

  $scope.tableParams = new ngTableParams(
    page: 1
    count: 10
    sorting:
      createdAt: "desc"
  ,
    total: 0
    getData: ($defer, params) ->
      Service.getData $defer, params, $scope.filter
      return
  )

  $scope.$watch "filter.$", (newVal, oldVal) ->
    $scope.tableParams.reload()  if angular.isDefined(oldVal) && angular.isDefined(newVal)
    return

  $scope.ifNew = (charId=0) ->
    if charId > 0
      $scope.newMessage charId

  $scope.messageShowInbox = () ->
    if $scope.showOutbox
      $scope.set_service_url('/messages.json')
      Service.reload $scope.tableParams
    $scope.showOutbox = false
    $scope.showNew = false
    $scope.sMsg = {}

  $scope.messageShowOutbox = () ->
    if !$scope.showOutbox
      $scope.set_service_url('/messages/outbox.json')
      Service.reload $scope.tableParams
    $scope.showOutbox = true
    $scope.showNew = false
    $scope.sMsg = {}


  $scope.newMessage = (charId = 0) ->
    if charId > 0
      url = '/messages/new.json?char_id='+charId
    else
      url = '/messages/new.json'
    $http.get(url).success (data) ->
      $scope.nMsg = data
      $scope.showNew = true
      $scope.sMsg = {}

  $scope.showMessage = (msg) ->
    $http.get('/messages/'+msg.id+'.json').success (data) ->
      $scope.sMsg = data

  $scope.replyMsg = (msg) ->
    $http.get('/messages/'+msg.id+'/reply.json').success (data) ->
      $scope.nMsg = data
      $scope.showNew = true
      $scope.sMsg = {}

  $scope.removeMsg = (msg, receiver=false) ->
    $http.delete('/messages/'+msg.id+'.json?receiver='+receiver).success (data) ->
      Service.reload $scope.tableParams
      $scope.sMsg = {}

  $scope.sendMsg = () ->
    $http.post('/messages.json', {message:$scope.nMsg}).success (data) ->
      $scope.showNew = false
      Service.reload $scope.tableParams

  $scope.closeForm = () ->
    $scope.nMsg = {}
    $scope.showNew = false

]