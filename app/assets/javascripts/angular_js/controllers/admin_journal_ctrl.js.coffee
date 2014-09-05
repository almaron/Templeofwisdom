@app.controller "AdminJournalCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.loadJournals = () ->
    $http.get('/admin/journals.json').success (data) ->
      $scope.journals = data

  $scope.loadJournals()

  $scope.types = [
    {name:'Статья', alias:'article'},
    {name:'Блочная', alias:'blocks'},
    {name:'Новички', alias:'newbies'},
    {name:'Галлерея', alias:'gallery'}
  ]

  $scope.createJournal = ->
    $http.post('/admin/journals.json', {journal: $scope.newJ}).success (data) ->
      $scope.journals.push data
      $scope.editJournal(data, true)
      $scope.newJ = {}

  $scope.createPage = ->
    $http.post('/admin/journals/'+$scope.current_journal.id+'/pages.json', {page: $scope.newPage}).success (data) ->
      $scope.current_journal.pages.push data
      $scope.current_page = data
      $scope.newPage.head = ""

  $scope.editJournal = (journal, cached=false) ->
    if cached
      $scope.current_journal = journal
    else
      $http.get('/admin/journals/'+journal.id+'.json').success (data) ->
        $scope.current_journal = data
    $scope.newPage = {page_type:'article', journal_id: journal.id}

  $scope.editPage = (page, cached=false) ->
    if cached
      $scope.current_page = page
    else
      $http.get('/admin/journals/'+$scope.current_journal.id+'/pages/'+page.id+'.json').success (data) ->
        $scope.current_page = data

  $scope.closeJournal = ->
    $scope.current_journal = {}

  $scope.closePage = ->
    $scope.current_page = {}


]