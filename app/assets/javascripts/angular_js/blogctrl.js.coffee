@app.controller 'BlogCtrl', ["$scope", 'BlogPost', 'BlogComment', ($scope, BlogPost, BlogComment) ->

  $scope.loadPosts = (page=1) ->
    $scope.posts = BlogPost.query({page:page}, ->
      $scope.newPost = {author: $scope.currentUser.default_char.name}
    )

  $scope.loadPost = (id) ->
    $scope.onePost = BlogPost.get({id:id})

  $scope.showPost = (post) ->
    $scope.onePost = post

  $scope.goBack = ->
    $scope.onePost = {}

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

  $scope.commentEditLink = (comment) ->
    (comment.user_id == $scope.currentUser.id) && (comment == $scope.onePost.comments.slice(-1)[0])

  $scope.commentDeleteLink = (comment) ->
    (comment.user_id == $scope.currentUser.id && (comment == $scope.onePost.comments.slice(-1)[0])) || ($scope.currentUser.group=='admin')

]