@app = angular.module('templeApp',["ngResource", "ngSanitize", "ngCookies","ngTable","xeditable","ui.tree",'duScroll'])

bootstrapAngular = ->
  angular.bootstrap("body", ["templeApp"])

$(document).on 'ready page:load', bootstrapAngular

#@app.config(['$locationProvider', ($locationProvider) ->
#  $locationProvider.disable()
#])


# @app.run (editableOptions, editableThemes) ->
#   editableThemes.temple =
#     formTpl: "<form class=\"form-inline editable-wrap\" role=\"form\"></form>"
#     noformTpl: "<span class=\"editable-wrap\"></span>"
#     controlsTpl: "<div class=\"editable-controls form-group\" ng-class=\"{'has-error': $error}\"></div>"
#     inputTpl: ""
#     errorTpl: "<div class=\"editable-error help-block\" ng-show=\"$error\" ng-bind=\"$error\"></div>"
#     buttonsTpl: "<span class=\"editable-buttons\"></span>"
#     submitTpl: "<button type=\"submit\"><span class=\"fa fa-check\"></span></button>"
#     cancelTpl: "<button type=\"button\" ng-click=\"$form.$cancel()\">" + "<span class=\"fa fa-times\"></span>" + "</button>"
#     buttonsClass: ""
#     inputClass: "inp inp-type2"
#     postrender: ->
#       switch @directiveName
#         when "editableText", "editableSelect", "editableTextarea", "editableEmail", "editableTel", "editableNumber", "editableUrl", "editableSearch", "editableDate", "editableDatetime", "editableTime", "editableMonth", "editableWeek"
#           @inputEl.addClass "form-control"
#           if @theme.inputClass
#             break  if @inputEl.attr("multiple") and (@theme.inputClass is "input-sm" or @theme.inputClass is "input-lg")
#             @inputEl.addClass @theme.inputClass
#         else
#           break
#       @buttonsEl.find("button").addClass @theme.buttonsClass  if @buttonsEl and @theme.buttonsClass
#       return

#   editableOptions.theme = 'temple'