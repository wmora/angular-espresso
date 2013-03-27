"use strict"

###
  Declare app level module which depends on filters, and services
###

angular.module("myApp", ["myApp.filters", "myApp.services", "myApp.directives"])
.config ["$routeProvider",
  ($routeProvider) ->
      $routeProvider.when "/view1", {templateUrl: 'partials/partial1', controller: Controller1}
      $routeProvider.when "/view2", {templateUrl: 'partials/partial2', controller: Controller2}
      $routeProvider.otherwise {redirectTo: "/view1"}
  ]


