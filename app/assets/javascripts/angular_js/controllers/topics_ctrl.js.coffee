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
      $window.location.assign data.redirect
    ).error((data) ->
      $scope.errors = data.errors
    )

  # Topic Show

  $scope.postPagination = {}

  $scope.initTopic = (forum_id, topic_id, page, post_id) ->
    $scope.topicInit = {forum_id: forum_id, topic_id:topic_id}
    $scope.postId = post_id if post_id >= 0
    $scope.currentPath = "/temple/"+$scope.topicInit.forum_id+"/t/"+$scope.topicInit.topic_id
    $scope.postPagination.cur = page
    $scope.loadTopic()


  $scope.loadTopic = (load_posts=false) ->
    data = Topic.get({forum_id: $scope.topicInit.forum_id, id: $scope.topicInit.topic_id}, ->
      if data.redirect
        $window.location.assign data.redirect
      else
        $scope.topic = data.topic
        $scope.path = data.path
        $scope.chars = data.chars
        $scope.postPagination.total = data.topic.pages_count
        $scope.loadPosts($scope.postPagination.cur) if load_posts
    )

  $scope.$watch "postPagination.cur", (newVal) ->
    if angular.isDefined newVal && newVal
      $scope.loadPosts newVal
      $window.history.pushState({},"",$scope.currentPath+"?page="+newVal)
#      $anchorScroll()

  $scope.loadPosts = (page) ->
    posts = Post.query {forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, page: page}, ->
      console.log posts.length
      if posts.length == 0
        $scope.postPagination.cur = $scope.postPagination.total
      else
        $scope.posts = posts


  $scope.addReply = ->
    $http.post($scope.currentPath+"/p.json", {post:$scope.newPost}
    ).success((newPost) ->
      if $scope.postPagination.cur == $scope.postPagination.total
        $scope.posts.push newPost
      else
        $scope.postPagination.cur = $scope.postPagination.total
      $scope.newPost = {char_id: $scope.currentUser.default_char.id }
      $scope.topic.last_post_id = newPost.id
    ).error((errors) ->
      $scope.newPost.errors = errors
    )

  $scope.removePost = (post) ->
    Post.delete {forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, id: post.id}, ->
      $scope.posts.splice($scope.posts.indexOf(post),1)
      $scope.loadTopic true

  $scope.updateTopic = ->
    Topic.update {forum_id: $scope.topicInit.forum_id, id: $scope.topicInit.topic_id, topic:{ head:$scope.topic.head }}

  $scope.editPost = (post) ->
    $scope.selectedPost = angular.copy post

  $scope.cancelEdit = ->
    $scope.selectedPost = {}

  $scope.updatePost = ->
    Post.update({forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, id: $scope.selectedPost.id, post: $scope.selectedPost})
    $scope.cancelEdit()
    $scope.loadPosts $scope.postPagination.cur

  $scope.toggleTopic = (hidden) ->
    Topic.update {forum_id: $scope.topicInit.forum_id, id: $scope.topicInit.topic_id, topic:{ hidden:hidden }}
    $scope.topic.isHidden = hidden

  $scope.commentPost = (post) ->
    comment = {comment: post.comment, commenter: post.commenter}
    getPost = Post.update({forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, id: post.id, post: comment}, ->
     $scope.posts[$scope.posts.indexOf(post)] = getPost
    )

]