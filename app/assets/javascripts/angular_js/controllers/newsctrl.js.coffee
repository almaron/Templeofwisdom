@app.controller 'NewsCtrl', ["$scope", "$location", "News", ($scope, $location, News) ->

  $scope.loadSomeNews = (number) ->
    $scope.news = News.query {limit: number}

  $scope.pagination = { }

  $scope.initNews = (page = 1) ->
    $scope.pagination.cur = page
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

  $scope.$watch 'pagination.cur', (newVal) ->
    $scope.loadNews newVal
    $location.path("/news").search({page:newVal})

  $scope.$watch 'currentUser.default_char', (newVal) ->
    $scope.newNews.author = newVal.name

  # Private methods

  $scope.getTotal = ->
    data = News.get_total {}, ->
      $scope.pagination.total = data.total

  $scope.loadNews = (page) ->
    $scope.news = News.query {page:page}

  $scope.initNewNews = ->
    $scope.newNews = {
      show:false,
      author: $scope.currentUser.default_char.name
    }

]