"use strict"

###
  Services
###

socketServer = document.domain

angular.module("myApp.services", [])
.value("version", "0.1")
.factory("Socket", ->

    socketService = {}

    socket = io.connect(socketServer)

    socketService.emit = (event, data) ->
      socket.emit event, data

    socketService.on = (event, callback) ->

      socket.on event, (data) ->
        callback data

    socketService
  )
.factory "User", ($resource) ->

  url = "/users/:userId"

  $resource url, {}, {
    list: {method: "GET", params: {userId: ""}},
    get: {method: "GET", params: {}}
  }