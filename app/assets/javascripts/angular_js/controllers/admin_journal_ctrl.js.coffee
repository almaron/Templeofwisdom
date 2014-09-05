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
      $scope.current_page.old_type = $scope.current_page.page_type
    else
      $http.get('/admin/journals/'+$scope.current_journal.id+'/pages/'+page.id+'.json').success (data) ->
        $scope.current_page = data
        $scope.current_page.old_type = $scope.current_page.page_type

  $scope.resetPage = ->
    if confirm('Точно изменить тип страницы?')
      $http.post('/admin/journals/'+$scope.current_journal.id+'/pages/'+$scope.current_page.id+'/reset.json', {page_type:$scope.current_page.page_type}).success (data) ->
        $scope.current_page = data
        $scope.current_page.old_type = data.page_type
    else
      $scope.current_page.page_type = $scope.current_page.old_type

  $scope.updateJournal = ->
    $http.put('/admin/journals/'+$scope.current_journal.id+'.json', {journal: $scope.current_journal}).success (data) ->
      $scope.current_journal = data
      $scope.loadJournals()

  $scope.updatePage = ->
    $http.put('/admin/journals/'+$scope.current_journal.id+'/pages/'+$scope.current_page.id+'.json', {page: $scope.current_page}).success (data) ->
      $scope.editJournal($scope.current_journal)

  $scope.addPageBlock = ->
    $scope.current_page.content_blocks.push ""
    $scope.current_page.images_attributes.push {remote_url:""}

  $scope.removePageBlock = (index) ->
   $scope.current_page.content_blocks.splice(index, 1)
   if $scope.current_page.images_attributes[index].id
     image_id = $scope.current_page.images_attributes[index].id
     $http.delete('/admin/journals/'+$scope.current_journal.id+'/pages/'+$scope.current_page.id+'/'+image_id+'.json')
   $scope.current_page.images_attributes.splice(index,1)

  $scope.addImage = ->
    $scope.current_page.images_attributes.push {remote_image_url:""}

  $scope.removeNewImage = (index) ->
    $scope.current_page.images_attributes.splice(index,1)

  $scope.removeImage = (image) ->
    $http.delete('/admin/journals/'+$scope.current_journal.id+'/pages/'+$scope.current_page.id+'/'+image.id+'.json').success (data) ->
      $scope.current_page.images.splice($scope.current_page.images.indexOf(image),1)

  $scope.closeJournal = ->
    $scope.current_journal = {}
    $scope.saveStatus = ""

  $scope.closePage = ->
    $scope.current_page = {}
    $scope.saveStatus = ""


]