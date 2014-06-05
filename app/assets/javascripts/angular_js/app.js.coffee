@app = angular.module('templeApp',["ngResource", "ngSanitize", "ngCookies"])

#@app.config ($locationProvider) ->
#  $locationProvider.html5Mode(true)

bootstrapAngular = ->
  angular.bootstrap("body", ["templeApp"])

$(document).on 'ready page:load', bootstrapAngular