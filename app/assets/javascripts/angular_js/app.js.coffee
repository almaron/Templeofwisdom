@app = angular.module('templeApp',["ngResource", "ngSanitize"])

#@app.factory "currentUser", ["$resource", ($resource) ->
#  $resource "/current_user.json", {}
#]

@app.controller "WrapperCtrl", ["$scope", "currentUser", ($scope, currentUser) ->

  $scope.currentUser = {}

  $scope.initWrapper = ->
   $scope.currentUser = currentUser.get()
  #  $scope.wrapBlog = BlogPost.query {limit:4}
  #  $scope.updateNews()

  $scope.updateNews = ->
    $scope.wrapNews = News.query {limit:4}

]

bootstrapAngular = ->
  angular.bootstrap("body", ["templeApp"])

$(document).on 'ready page:load', bootstrapAngular