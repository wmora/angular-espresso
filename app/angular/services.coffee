"use strict"

###
  Services
###

socketServer = document.domain

angular.module("myApp.services", [])
.value("version", "0.2.2")
.factory("Socket",
  ["$rootScope",
    ($rootScope) ->

      socketService = {}

      socket = io.connect(socketServer)

      socketService.emit = (event, data) ->
        socket.emit event, data

      socketService.on = (event, callback) ->
        socket.on event, (data) ->
          $rootScope.$apply ->
            callback data

      socketService
  ]
)
.factory "User",
  ["$resource",
    ($resource) ->

      url = "/users/:userId"

      $resource url, {}, {

        list: {method: "GET", params: {userId: ""}},
        get: {method: "GET", params: {}}

      }
  ]