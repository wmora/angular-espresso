fs = require "fs"

{print} = require "sys"
{spawn} = require "child_process"

build = (callback) ->
  options = ["-c", "-o", ".espresso", "."]
  coffee = spawn "coffee", options

  coffee.stderr.on "data", (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on "data", (data) ->
    print data.toString()
  coffee.on "exit", (code) ->
    callback?() if code is 0

task "build", "Build .espresso from here", ->
  build()
