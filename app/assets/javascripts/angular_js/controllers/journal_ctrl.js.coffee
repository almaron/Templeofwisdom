@app.controller "JournalCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.journal = {page_count:-1, current_page: -1}
  $scope.tag  = { current_page: -1 }
  $scope.initJournal = (id, page) ->
    $http.get('/journals/'+id+'.json').success (data) ->
      $scope.journal = data
      if page >= 0
        $scope.journal.current_page = page
        $scope.getPage page

  $scope.initTag = (tag) ->
    $http.get('/journals/tag/'+tag+'.json').success (data) ->
      $scope.tag = data

  $scope.getPage = (page) ->
    if $scope.journal.page_count >= page
      $scope.current_page = $scope.journal.pages[page]
      if !$scope.journal.pages[page].cached
        $http.get('/journals/'+$scope.journal.id+'/p/'+$scope.current_page.id+'.json').success (data) ->
          $scope.journal.pages[page] = $scope.current_page = data

  $scope.getTagPage = (id) ->
    if !angular.isDefined($scope.tag.pages[id]) || !$scope.tag.pages[id].cached
      $http.get('/journals/p/'+id+'.json').success (data) ->
        $scope.tag.pages[id] = $scope.current_page = data
    else
      $scope.current_page = $scope.tag.pages[id]

]