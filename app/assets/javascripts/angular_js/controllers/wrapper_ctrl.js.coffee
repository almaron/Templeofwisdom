@app.controller "WrapperCtrl", ["$scope", "$cookies", "currentUser", "News", "BlogPost", '$timeout', ($scope, $cookies, currentUser, News, BlogPost, $timeout) ->

  $scope.currentUser = {}

  $scope.fontSizes = ["8px","10px","12px","14px","16px","18px","20px"]
  $scope.currentFont = $cookies.currentFont || "14px"

  $scope.initWrapper = (flash = false) ->
    $scope.currentUser = currentUser.get()
    $scope.currentUser.default_char = {name:""} unless $scope.currentUser.default_char
    $scope.wrapBlog = BlogPost.query {limit:4}
    $scope.updateMainNews()
    $scope.showFlash = flash


  $scope.updateMainNews = ->
    $scope.wrapNews = News.query {limit:4}

  $scope.decFont = ->
    int = $scope.fontSizes.indexOf($scope.currentFont)
    $cookies.currentFont = $scope.currentFont = $scope.fontSizes[int-1] unless int == 0

  $scope.incFont = ->
    int = $scope.fontSizes.indexOf($scope.currentFont)
    $cookies.currentFont = $scope.currentFont = $scope.fontSizes[int+1] unless int == $scope.fontSizes.length - 1

  $scope.dropFont = ->
    $cookies.currentFont = $scope.currentFont = "14px"

  $scope.clearFlash = ->
    $scope.showFlash = false
    $scope.flash = {}

  $scope.flashMessage = (message, message_class='notice') ->
    $scope.flash = {message: message, class: message_class}
    $scope.showFlash = true

  $scope.flashMessageTimeout = (message, message_class='notice', timing = 4000) ->
    $scope.flashMessage(message, message_class);
    $timeout $scope.clearFlash, timing


]