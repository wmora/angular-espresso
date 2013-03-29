"use strict"

###
  Declare app level module which depends on filters, and services
###

angular.module("myApp", ["myApp.filters", "myApp.services", "myApp.directives"])
.config ["$routeProvider",
  ($routeProvider) ->
    $routeProvider.when "/home", {templateUrl: "partials/home", controller: UsersCtrl}
    $routeProvider.when "/user/:userId", {templateUrl: "partials/user", controller: UserDetailCtrl}
    $routeProvider.when "/socket", {templateUrl: "partials/socket", controller: SocketCtrl}
    $routeProvider.otherwise {redirectTo: "/home"}
  ]


