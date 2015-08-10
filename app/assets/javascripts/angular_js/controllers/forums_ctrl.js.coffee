@app.controller "ForumsCtrl", ["$scope", "$http", '$q', "Forum", ($scope, $http, $q, Forum) ->

  $scope.forumPagination = {}
  $scope.toForumId = 0
  $scope.loadedForum = false

  $http.get('/temple/move_topic.json').success (data) ->
    $scope.all_forums = data

  $scope.loadRoot = ->
    $scope.forums = Forum.query()

  $scope.initForum = (forum_id, page) ->
    $scope.forum_id = forum_id
    $scope.loadForum(forum_id, page)

  $scope.loadForum = (id, page) ->
    data = Forum.get {id:id}, ->
      $scope.forum = data.forum
      $scope.path = data.path
      $scope.forumPagination.cur = page unless $scope.forum.isCategory
      $scope.loadedForum = true


  $scope.$watch "forumPagination.cur", (newVal) ->
    $scope.loadTopics(newVal) unless typeof(newVal) == "undefined"

  $scope.loadTopics = (page) ->
    $http.get("/temple/"+$scope.forum_id+"/t.json?page="+page).success (data)->
      $scope.topics = data.topics
      $scope.forumPagination.total = data.total

  selected = 0

  breakSelect = ->
    selected = 0
    angular.element($('#selectAll')).attr('checked',false)
    $scope.loadTopics($scope.forumPagination.cur)

  $scope.clickModerate = ->
    $scope.moderateOn = !$scope.moderateOn
    if $scope.moderateOn
      $scope.moderateForums = $scope.all_forums
    else
      $scope.moderateForums = []
      selected = 0
      angular.element($('#selectAll')).attr('checked',false)


  $scope.selectAll = ->
    selected = (selected + 1) % 2
    angular.forEach $scope.topics, (topic) ->
      topic.selected = selected

  $scope.moveTopics = ->
    toForumId = $scope.toForumId
    if toForumId == $scope.forum_id
      alert 'Некуда переносить!'
      return
    posts = []
    angular.forEach $scope.topics, (topic) ->
      if topic.selected == 1
        posts.push $http.put('/temple/move_topic.json', { topic_id: topic.id, to_forum_id: toForumId })
    $q.all(posts).then ->
      $scope.toForumId = null
      breakSelect()


  $scope.deleteTopics = ->
    if confirm('Уверены?')
      ids = []
      angular.forEach $scope.topics, (topic) ->
        if topic.selected == 1
          ids.push topic.id
      $http.delete('/temple/move_topic.json?forum_id='+$scope.forum_id+'&delete_topics='+ids.join(',')).success (data) ->
        $scope.loadTopics $scope.forumPagination.cur

  $scope.openTopics = ->
    posts = []
    angular.forEach $scope.topics, (topic) ->
      if topic.selected == 1
        posts.push $http.put('/temple/'+$scope.forum_id+'/t/'+topic.id+'.json', { topic: { closed: 0 } })
    $q.all(posts).then ->
      breakSelect()


  $scope.closeTopics = ->
    posts = []
    angular.forEach $scope.topics, (topic) ->
      if topic.selected == 1
        posts.push $http.put('/temple/'+$scope.forum_id+'/t/'+topic.id+'.json', { topic: { closed: 1 } })
    $q.all(posts).then ->
      breakSelect()



  $scope.topicClass = (topic) ->
    if topic.closed
      return 'forum-topic-read-locked'
    else
      return 'forum-topic-unread'

]
