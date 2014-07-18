@app.controller 'BlogCtrl', ["$scope", "$window", 'BlogPost', 'BlogComment', ($scope, $window, BlogPost, BlogComment) ->

  $scope.blogPagination = { }

  $scope.initBlog = (page = 1) ->
    $scope.blogPagination.cur = page
    $scope.getTotal()
    $scope.initPost()

  $scope.newPost = {}

  $scope.initOnePost = (id) ->
    $scope.loadPost id
    $scope.onlyPost = true

  $scope.loadPosts = (page) ->
    $scope.posts = BlogPost.query({page:page})

  $scope.loadPost = (id) ->
    $scope.onePost = BlogPost.get({id:id})

  $scope.showPost = (post) ->
    $scope.onePost = post
    $window.history.pushState({controller:"blogs", action:"show", post_id:"post_id"}, "", '/blog/'+post.id)

  $scope.goBack = ->
    $scope.onePost = {}
    $window.history.pushState({controller:"blogs", action:"index", page:$scope.blogPagination.cur}, "", '/blog?page='+$scope.blogPagination.cur)

  $scope.createPost = (post) ->
    post = BlogPost.save({post:post}, ->
      $scope.posts.unshift post
      $scope.newPost = {}
    )

  $scope.updatePost = (post) ->
    ind = $scope.posts.indexOf(post)
    orpost = BlogPost.update {id: post.id, post: post}, ->
      $scope.posts[ind] = orpost
      $scope.showPost(orpost)

  $scope.deletePost = (post) ->
    BlogPost.delete {id:post.id}, ->
      $scope.posts.splice $scope.posts.indexOf(post), 1
      $scope.goBack()

  $scope.addComment = (comment) ->
    com = BlogComment.save {post_id:$scope.onePost.id, comment:comment}, ->
      $scope.onePost.comments.push com
    $scope.newComment = {show:1}

  $scope.updateComment = (comment) ->
    ind = $scope.onePost.comments.indexOf(comment)
    comm = BlogComment.update {post_id: $scope.onePost.id, id: comment.id, comment: comment}, ->
      $scope.onePost.comments[ind] = comm

  $scope.deleteComment = (comment) ->
    BlogComment.delete({post_id:$scope.onePost.id, id:comment.id})
    $scope.onePost.comments.splice($scope.onePost.comments.indexOf(comment),1)

  # Private methods

  $scope.$watch 'blogPagination.cur', (newVal) ->
    if angular.isDefined newVal
      $scope.loadPosts newVal
#      $window.history.pushState({controller:"blogs", action:"index", page:newVal}, "", '/blog?page='+newVal)

  $scope.$watch 'currentUser.default_char', (newVal) ->
    $scope.newPost.author = newVal.name if angular.isDefined newVal && angular.isDefined $scope.newPost

  $scope.initPost = ->
    $scope.newPost = {author: $scope.currentUser.default_char.name}

  $scope.getTotal = ->
    data = BlogPost.get_total {}, ->
      $scope.blogPagination.total = data.total

  $scope.commentEditLink = (comment) ->
    (comment.user_id == $scope.currentUser.id) && (comment == $scope.onePost.comments.slice(-1)[0])

  $scope.commentDeleteLink = (comment) ->
    (comment.user_id == $scope.currentUser.id && (comment == $scope.onePost.comments.slice(-1)[0])) || ($scope.currentUser.group=='admin')

]