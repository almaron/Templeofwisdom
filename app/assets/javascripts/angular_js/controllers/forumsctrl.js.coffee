@app.controller "ForumsCtrl", ["$scope", "$http", "Forum", ($scope, $http, Forum) ->

  $scope.forumPagination = {}

  $scope.loadRoot = ->
    $scope.forums = Forum.query()
    
  $scope.initForum = (forum_id, page) ->
    $scope.forum_id = forum_id
    $scope.loadForum(forum_id, page)


  $scope.loadForum = (id, page) ->
    data = Forum.get {id:id}, ->
      $scope.forum = data.forum
      $scope.path = data.path
      $scope.forumPagination.cur = page unless $scope.forum.isCategory


  $scope.$watch "forumPagination.cur", (newVal) ->
    $scope.loadTopics(newVal) unless typeof(newVal) == "undefined"

  $scope.loadTopics = (page) ->
    $http.get("/temple/"+$scope.forum_id+"/t.json?page="+page).success (data)->
      $scope.topics = data.topics
      $scope.forumPagination.total = data.total

]