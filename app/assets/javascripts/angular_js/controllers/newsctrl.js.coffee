@app.controller 'NewsCtrl', ["$scope", "$window", "News", ($scope, $window, News) ->

  $scope.loadSomeNews = (number) ->
    $scope.news = News.query {limit: number}

  $scope.newsPagination = { }

  $scope.initNews = (page = 1) ->
    $scope.newsPagination.cur = page
    $scope.getTotal()
    $scope.newNews = {show:false}
    $scope.initNewNews()


  $scope.updateNews = (newNews) ->
    sin = $scope.news.indexOf(newNews)
    $scope.news[sin] = News.update({id: newNews.id, news: newNews} )
    $scope.newNews = {}
    $scope.updateMainNews()

  $scope.removeNews = (news) ->
    News.delete({id:news.id})
    $scope.news.splice($scope.news.indexOf(news),1)
    $scope.updateMainNews()
    $scope.getTotal()


  $scope.createNews = ->
    news = News.save {news: $scope.newNews}, ->
      if news
        $scope.news.unshift news
        $scope.initNewNews()
        $scope.updateMainNews()
        $scope.getTotal()
      else
        $scope.errors = news.errors

  $scope.$watch 'newsPagination.cur', (newVal) ->
    if angular.isDefined newVal
      $scope.loadNews newVal
      $window.history.pushState({controller:"news", action:"index", page:newVal},"","/news?page="+newVal)

  $scope.$watch 'currentUser.default_char', (newVal) ->
    $scope.newNews.author = newVal.name if (angular.isDefined(newVal) && angular.isDefined($scope.newNews))

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