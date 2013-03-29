"use strict"

###
  Directives
###

angular.module("myApp.directives", ["ngResource"])
.directive "appVersion", ["version", (version) ->
  (scope, elm, attrs) ->
    elm.text version
]
