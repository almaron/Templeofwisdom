@app.controller 'NewsCtrl', ["$scope", "$http", "News", ($scope, $http, News) ->

  $scope.newsPagination = { }

  $scope.initNews = (page = 1) ->
    $scope.newsPagination.cur = page
    $scope.getTotal()
    $scope.newNews = {show:false}
    $scope.initNewNews()


  $scope.updateNews = (newNews) ->
    sin = $scope.news.indexOf(newNews)
    $scope.news[sin] = News.update({id: newNews.id, news: newNews} )
    $scope.initNewNews()

  $scope.removeNews = (news) ->
    News.delete({id:news.id})
    $scope.news.splice($scope.news.indexOf(news),1)
    $scope.getTotal()


  $scope.createNews = ->
    newNews = angular.copy($scope.newNews)
    news = News.save {news: $scope.newNews}, ->
      if news
        $scope.news.unshift news
        $scope.initNewNews()
        $scope.getTotal()
      else
        $scope.errors = news.errors
    $scope.sendMaker(newNews)

  $scope.$watch 'newsPagination.cur', (newVal) ->
    if angular.isDefined newVal
      $scope.loadNews newVal

  $scope.$watch 'currentUser.default_char', (newVal) ->
    $scope.newNews.author = newVal.name if (angular.isDefined(newVal) && angular.isDefined($scope.newNews))

  $scope.sendMaker = (news) ->
    $http.post('/news/maker', {news: news}).success (data) ->
      console.log data
      $scope.makerShow = true
      $scope.maker = data

  # Private methods

  $scope.getTotal = ->
    data = News.get_total {}, ->
      $scope.newsPagination.total = data.total

  $scope.loadNews = (page) ->
    $scope.news = News.query {page:page}

  $scope.initNewNews = ->
    $scope.newNews = {
      show:false,
      author: $scope.currentUser.default_char.name
    }

]
