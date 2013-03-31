"use strict"

###
  Controllers
###

AppCtrl = ($scope) ->
  $scope.name = "Espresso"

AppCtrl.$inject = ["$scope"]

UsersCtrl = ($scope, User) ->
  $scope.loadUsers = ->
    $scope.users = {}
    User.list {}
    , (data) ->
      $scope.users = data.message

UsersCtrl.$inject = ["$scope", "User"]

UserDetailCtrl = ($scope, $routeParams, User) ->
  $scope.user =
    User.get {userId: $routeParams.userId}
    , (data) ->
      $scope.user = data.user

UserDetailCtrl.$inject = ["$scope", "$routeParams", "User"]

SocketCtrl = ($scope, Socket) ->

  Socket.on "pong", (data) ->
    $scope.response = data.data

  $scope.ping = ->
    Socket.emit("ping", {})

SocketCtrl.$inject = ["$scope", "Socket"]