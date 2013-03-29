"use strict"

###
  Filters
###

angular.module("myApp.filters", [])
.filter "title",
  ->
    (user) ->
      "#{user.id} - #{user.name}"