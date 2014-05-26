@app = angular.module('templeApp',["ngResource", "ngSanitize"])

@app.controller "WrapperCtrl", ["$scope", "currentUser", "News", "BlogPost", ($scope, currentUser, News, BlogPost) ->

  $scope.currentUser = {}

  $scope.initWrapper = ->
   $scope.currentUser = currentUser.get()
   $scope.currentUser.default_char = {name:""} unless $scope.currentUser.default_char
   $scope.wrapBlog = BlogPost.query {limit:4}
   $scope.updateMainNews()

  $scope.updateMainNews = ->
    $scope.wrapNews = News.query {limit:4}

]

bootstrapAngular = ->
  angular.bootstrap("body", ["templeApp"])

$(document).on 'ready page:load', bootstrapAngular