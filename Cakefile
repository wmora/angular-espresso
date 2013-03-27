fs = require "fs"

{print} = require "sys"
{spawn} = require "child_process"

buildApp = ->
  options = ["-c", "-b", "-o", ".espresso", "app"]
  compile options

buildServer = ->
  options = ["-c", "-b", "app.coffee"]
  compile options

buildClient = ->
  options = ["-c", "-b", "-o", "public", "app/public"]
  compile options

compile = (options) ->
  coffee = spawn "coffee", options
  coffee.stderr.on "data", (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on "data", (data) ->
    print data.toString()
  coffee.on "exit", (code) ->
    callback?() if code is 0

task "build", "Building app", ->
  buildApp()
  buildServer()
  buildClient()
