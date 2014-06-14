@app.controller "TopicsCtrl", ["$scope", "$http", "$window", "Topic", "Post", ($scope, $http, $window, Topic, Post) ->

  # Topic New
  $scope.newPost = {}

  $scope.initNewTopic = (forum_id) ->
    $http.get("/temple/"+forum_id+"/t/new.json").success (data) ->
      $scope.path = data.path
      $scope.newTopic = data.topic
      $scope.chars = data.chars
    $scope.forumId = forum_id

  $scope.$watch "currentUser.default_char.id", (newVal) ->
    if typeof newVal != "undefined"
      $scope.newPost.char_id = newVal


  $scope.createTopic = ->
    console.log "Create clicked"
    $http.post("/temple/"+$scope.forumId+"/t.json",
      {post:$scope.newPost, topic:$scope.newTopic}
    ).success((data) ->
      $window.location.href data.redirect
    ).error((data) ->
      $scope.errors = data.errors
    )

  # Topic Show

  $scope.postPagination = {cur:null}

  $scope.initTopic = (forum_id, topic_id, page) ->
    $scope.init = {forum_id: forum_id, topic_id:topic_id}
    $scope.currentPath = "/temple/"+$scope.init.forum_id+"/t/"+$scope.init.topic_id
    data = Topic.get({forum_id: forum_id, id: topic_id}, ->
      $scope.topic = data.topic
      $scope.path = data.path
      $scope.postPagination.total = data.topic.pages_count
    )
    $scope.postPagination.cur = page

  $scope.$watch "postPagination.cur", (newVal) ->
    if typeof newVal != "undefined"
      $scope.loadPosts newVal
      $window.history.pushState({controller:"topics", action:"show", topic_id: $scope.init.topic_id, page:newVal},"",$scope.currentPath+"?page="+newVal)

  $scope.loadPosts = (page) ->
    posts = Post.query {forum_id: $scope.init.forum_id, topic_id: $scope.init.topic_id, page: page}, ->
      if posts.length == 0
        $scope.postPagination.cur = $scope.postPagination.total
      else
        $scope.posts = posts


  $scope.addReply = ->
    $http.post($scope.currentPath+"/p.json", {post:$scope.newPost}
    ).success((newPost) ->
      if $scope.postPagination.cur == $scope.postPagination.total
        $scope.posts.push newPost
        $scope.newPost = {char_id: $scope.currentUser.default_char.id }
      else
        $scope.postPagination.cur = $scope.postPagination.total
    ).error((errors) ->
      $scope.newPost.errors = errors
    )
]