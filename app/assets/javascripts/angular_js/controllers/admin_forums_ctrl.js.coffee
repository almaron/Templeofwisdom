@app.controller "AdminForumsCtrl", ["$scope", "$filter", "$http", "AdminForum", ($scope, $filter, $http, Forum) ->

  $scope.removedItems = []
  $scope.newForum = {}

  $scope.loadForums = () ->
    $scope.forums = Forum.query()

  $scope.forumsTreeOptions = {
    accept: (sourceNodeScope, destNodesScope, destIndex) ->
      ttt = typeof destNodesScope.forum
      return (ttt == "undefined") || destNodesScope.forum.isCategory
    dropped: (event) ->
      event.source.nodeScope.$modelValue.sort_order = event.dest.index
      console.log "" + event.source.nodeScope.$modelValue.name + ": " + event.dest.index
    dragStart: (event) ->
      $scope.editForum = {}
  }

  $scope.removeItem = (scope) ->
    Forum.delete {id:scope.forum.id}
    scope.remove(this)

  $scope.openAddForm = (scope) ->
    $scope.newForum = {
      parent_id: scope.forum.id,
      technical: ""+scope.forum.technical,
      is_category: "1",
      hidden: ""+scope.forum.hidden,
    }
    scope.forum.addNew = true

  $scope.closeAddForm = (scope) ->
    $scope.newForum = {}
    scope.forum.addNew = false

  $scope.addItem = (scope) ->
    node = scope.$modelValue
    newforum = Forum.save {forum: $scope.newForum}, ->
      node.children.push newforum
      $scope.newForum.name = ""

  $scope.addRootItem = () ->
    newforum = Forum.save {forum: $scope.newForum}, ->
      $scope.forums.push newforum
      $scope.newForum = {}

  $scope.levelTree = () ->
    $scope.level_success = false
    $http.put("/admin/forums.json", {tree:$filter('level_tree')($scope.forums)}).success (data) ->
      $scope.level_success = data.success

  $scope.editItem = (scope) ->
    $scope.editForum = angular.copy scope.forum
    $scope.editForum.is_category = "" + $scope.editForum.is_category
    $scope.editForum.technical = "" + $scope.editForum.technical
    $scope.editForum.hidden = "" + $scope.editForum.hidden

  $scope.cancelEdit = () ->
    $scope.editForum = {}

  $scope.updateItem = (scope) ->
    node = scope.$modelValue
    forum = Forum.update {id:$scope.editForum.id, forum:$scope.editForum}, ->
      $scope.editForum = {}
      $scope.loadForums()
]