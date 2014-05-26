@app.controller "GuestBookCtrl", ["$scope","GuestPost", ($scope, GuestPost) ->

  $scope.loadPosts = (page=1) ->
    $scope.posts = GuestPost.query({page:page})
    $scope.resetPost()

  $scope.resetPost = ->
    $scope.newPost = GuestPost.reset

  $scope.createPost = (post) ->
    post = GuestPost.save({guest_post:post}, ->
      $scope.posts.unshift post
      $scope.resetPost()
    )
  

]