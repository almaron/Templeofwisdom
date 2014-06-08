@app.controller "ConfigsCtrl", ["$scope", "Config", "ArrayService", ($scope, Config, ArrayService) ->

  $scope.getConfigs = ->
    $scope.configs = Config.query()
    $scope.newConfig = {}

  $scope.editConfig = (config) ->
    $scope.editConf = angular.copy config
    config.edit = true

  $scope.updateConfig = ->
    config = $scope.editConf
    ind = ArrayService.findIndex($scope.configs, "id", config.id)
    conf = Config.update({id:config.id, config: config}, ->
      $scope.configs[ind] = conf;
      $scope.editConf = {}
    )

  $scope.removeConfig = (config)->
    Config.delete {id:config.id}
    $scope.configs.splice($scope.configs.indexOf(config),1)

  $scope.createConfig = ->
    $scope.configs.push Config.save({config:$scope.newConfig})
    $scope.newConfig = {}

  $scope.resetConfig = (config) ->
    config.edit = false
    $scope.editConf = {}
]