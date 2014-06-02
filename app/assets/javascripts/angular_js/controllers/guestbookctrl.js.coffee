@app.controller "GuestBookCtrl", ["$scope","GuestPost", ($scope, GuestPost) ->

  $scope.loadPosts = (page=1) ->
    $scope.posts = GuestPost.query({page:page})
    $scope.resetPost()

  $scope.resetPost = ->
    $scope.newPost = GuestPost.reset()

  $scope.createPost = (post) ->
    post = GuestPost.save({guest_post:post}, ->
      $scope.posts.unshift post
      $scope.resetPost()
    )

  $scope.updatePost = (post) ->
    ind = $scope.posts.indexOf(post)
    $scope.posts[ind] = GuestPost.update({id:post.id, guest_post:post})

  $scope.removePost = (post) ->
    ind = $scope.posts.indexOf(post)
    GuestPost.delete({id:post.id}, ->
      $scope.posts.splice(ind,1)
    )
]