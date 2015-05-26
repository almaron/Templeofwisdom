@app.controller "TopicsCtrl", ["$scope", "$http", "$window", "$timeout", "Topic", "Post", 'ArrayService', ($scope, $http, $window, $timeout, Topic, Post, Service) ->

  # Topic New
  $scope.newPost = {}

  $scope.initNewTopic = (forum_id) ->
    $http.get("/temple/"+forum_id+"/t/new.json").success (data) ->
      $scope.path = data.path
      $scope.newTopic = data.topic
      $scope.chars = data.chars
      $scope.sChar = Service.findBy($scope.chars, 'default', true)
      $scope.newPost.char_id = $scope.sChar.id
    $scope.forumId = forum_id

  $scope.updateChar = (array, id) ->
    if angular.isDefined id
      console.log(id)
      $scope.sChar = Service.findBy(array, 'id', id)


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
  $scope.informMaster = false
  $scope.informChars = []

  $scope.initTopic = (options) ->
    $scope.topicInit = { forum_id: options.forum_id, topic_id: options.topic_id }
    $scope.currentPath = "/temple/"+$scope.topicInit.forum_id+"/t/"+$scope.topicInit.topic_id
    if options.post
      $scope.loadTopic({post: options.post})
      $scope.postId = options.post
      $scope.initial = true
    else
      $scope.loadTopic({page: options.page || 1})


  $scope.loadTopic = (options = {}, load_posts = false) ->
    get_options = angular.extend({forum_id: $scope.topicInit.forum_id, id: $scope.topicInit.topic_id}, options)
    data = Topic.get(get_options, ->
      if data.redirect
        $window.location.assign data.redirect
      else
        $scope.topic = data.topic
        $scope.path = data.path
        $scope.chars = data.chars
        flushNewPost()
        $scope.postPagination.total = data.topic.pages_count
        if options.post
          $scope.postPagination.cur = data.topic.current_page
        if options.page
          if options.page > data.topic.pages_count
            $scope.postPagination.cur = data.topic.pages_count
          else
            $scope.postPagination.cur = options.page
        $scope.loadPosts($scope.postPagination.cur) if load_posts
    )

  $scope.$watch "postPagination.cur", (newVal, oldVal) ->
    if angular.isDefined(newVal) && newVal && (newVal != oldVal)
      $scope.loadPosts newVal

  $scope.loadPosts = (page) ->
    $http.get(
      $scope.currentPath+'/p.json?page=' + page
    ).success (data) ->
      if data.length == 0
        $scope.postPagination.cur = $scope.postPagination.total
      else
        $scope.posts = data
        $timeout(
          () ->
            if $scope.initial && $scope.postId
              post = $('#pid_'+$scope.postId)
              $(document).scrollTop(post[0].offsetTop)
              $scope.initial = false
            else
              $(document).scrollTop(270)
          0
        )

  flushNewPost = ->
    $scope.sChar = Service.findBy($scope.chars, 'default', true)
    $scope.newPost = {char_id: $scope.sChar.id }

  $scope.addReply = ->
    $http.post($scope.currentPath+"/p.json", {post:$scope.newPost, inform:$scope.informChars, inform_master: $scope.informMaster}
    ).success((newPost) ->
      if $scope.postPagination.cur == $scope.postPagination.total
        $scope.posts.push newPost
      else
        $scope.postPagination.cur = $scope.postPagination.total
      flushNewPost()
      $scope.topic.last_post_id = newPost.id
    ).error((errors) ->
      $scope.newPost.errors = errors
    )

  $scope.removePost = (post) ->
    Post.delete {forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, id: post.id}, ->
      $scope.posts.splice($scope.posts.indexOf(post),1)
      $scope.loadTopic $scope.postPagination.cur, true

  $scope.updateTopic = ->
    Topic.update {forum_id: $scope.topicInit.forum_id, id: $scope.topicInit.topic_id, topic:{ head:$scope.topic.head }}

  $scope.editPost = (post) ->
    $scope.selectedPost = angular.copy post
    if Service.findBy($scope.chars, 'id', post.char_id)
      $scope.eChar = Service.findBy($scope.chars, 'id', post.char_id)
    else
      $http.get('/chars/'+post.char_id+'.json?short=true').success (data) ->
        $scope.eChar = data
        $scope.selectedPost.setChar = data.name


  $scope.cancelEdit = ->
    $scope.selectedPost = {}

  $scope.updatePost = ->
    Post.update({forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, id: $scope.selectedPost.id, post: $scope.selectedPost})
    $scope.cancelEdit()
    flushNewPost()
    $scope.loadPosts $scope.postPagination.cur

  $scope.toggleTopic = (hidden) ->
    Topic.update {forum_id: $scope.topicInit.forum_id, id: $scope.topicInit.topic_id, topic:{ hidden:hidden }}
    $scope.topic.isHidden = hidden

  $scope.commentPost = (post) ->
    comment = {comment: post.comment, commenter: post.commenter}
    getPost = Post.update({forum_id: $scope.topicInit.forum_id, topic_id: $scope.topicInit.topic_id, id: post.id, post: comment}, ->
     $scope.posts[$scope.posts.indexOf(post)] = getPost
    )

  $scope.toggleInform = (cid) ->
    idx = $scope.informChars.indexOf(cid)
    if idx < 0
      $scope.informChars.push(cid)
    else
      $scope.informChars.splice(idx,1)

  $scope.toggleInformMaster = () ->
    $scope.informMaster = !$scope.informMaster
]