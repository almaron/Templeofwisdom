@app.controller 'NewsCtrl', ["$scope","News", ($scope, News) ->

  $scope.loadSomeNews = (number) ->
    $scope.news = News.query {limit: number}

  $scope.loadNews = (page = 1) ->
    $scope.news = News.query {page:page}, ->
      $('.text-simple').removeClass('hide')
      if $scope.currentUser.default_char then $scope.newNews.author = $scope.currentUser.default_char.name
    $scope.newNews = {show:false}



  $scope.updateNews = (newNews) ->
    sin = $scope.news.indexOf(newNews)
    $scope.news[sin] = News.update({id: newNews.id, news: newNews} )
    $scope.newNews = {}
    $scope.updateMainNews()

  $scope.removeNews = (news) ->
    News.delete({id:news.id})
    $scope.news.splice($scope.news.indexOf(news),1)
    $scope.updateMainNews()


  $scope.createNews = (newNews) ->
    news = News.save {news: newNews}, ->
      if news
        $scope.news.unshift news
        $scope.newNews = {}
        $scope.updateMainNews()
      else
        $scope.errors = news.errors

]