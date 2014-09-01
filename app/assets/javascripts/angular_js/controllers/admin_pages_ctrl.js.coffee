@app.controller "AdminPagesCtrl", ["$scope", "$http", "$filter", ($scope, $http, $filter) ->

  $scope.newPage = {}

  loadPages = ->
    $http.get('/admin/pages.json').success (data) ->
      $scope.pages = data

  loadPages()

  $scope.pagesTreeOptions = {
    dropped: (event) ->
      event.source.nodeScope.$modelValue.sort_order = event.dest.index
    dragStart: (event) ->
      $scope.editPage = {}
  }

  $scope.removeItem = (scope) ->
    $http.delete('/admin/pages/'+scope.page.id+'.json').success (data) ->
      scope.remove(this)

  $scope.openAddForm = (scope) ->
    $scope.newPage = {
      parent_id: scope.page.id,
      isPublished: false
      published: 0
    }
    scope.page.addNew = true

  $scope.closeAddForm = (scope) ->
    $scope.newPage = {}
    scope.page.addNew = false

  $scope.addItem = (scope) ->
    $scope.newPage.page_title = $scope.newPage.head
    node = scope.$modelValue
    $http.post('/admin/pages.json', {page:$scope.newPage}).success (data) ->
      node.children.push data
      $scope.newPage.head = ""

  $scope.addRootItem = () ->
    $scope.newPage.page_title = $scope.newPage.head
    $http.post('/admin/pages.json', {page: $scope.newPage}).success (data) ->
      $scope.pages.push data
      $scope.newPage = {}

  $scope.levelTree = () ->
    $scope.level_success = false
    $http.put("/admin/pages.json", {tree:$filter('level_tree')($scope.pages)}).success (data) ->
      $scope.level_success = data.success

  $scope.editItem = (scope) ->
    $scope.editPage = angular.copy scope.page
    $scope.editPage.published = "" + $scope.editPage.published

  $scope.fullEdit = (page) ->
    window.location.assign('/admin/pages/'+page.id+'/edit')

  $scope.cancelEdit = () ->
    $scope.editPage = {}

  $scope.updateItem =  ->
    $http.put('/admin/pages/'+$scope.editPage.id+'.json', {page:$scope.editPage}).success (data) ->
      $scope.editPage = {}
      loadPages()

]