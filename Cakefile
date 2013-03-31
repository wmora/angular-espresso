fs = require "fs"
uglifyjs = require "uglify-js"

{print} = require "sys"
{exec} = require "child_process"

###
  Directory where the Espresso module will be generated
###
ESPRESSO_DIR = ".espresso"

###
  Module's index filename. DO NOT MODIFY!
###
ESPRESSO_INDEX = "index.coffee"

###
  Directory where the source code is
###
APP_DIR = "app"

###
  Module directories
###
APP_SRC = [
  "config",
  "routes",
  "services",
  "socket"
]

###
  Server filename. File that is run by Node
###
SERVER_FILENAME = "app.coffee"

###
  Angular app source folder under APP_DIR
###
ANGULAR_APP_SRC = "angular"

###
  Client files (static resources) output directory. DO NOT MODIFY!
###
PUBLIC_DIR = "public"

###
  Angular app output folder under PUBLIC_DIR
###
ANGULAR_APP_OUT = "angular"

###
  Client scripts source folder other than angular files
###
CLIENT_RESOURCES_SRC = "resources"

###
  Client scripts output folder other than angular files
###
CLIENT_RESOURCES_OUT = "js"


buildModule = ->
  options = "-c -b -o"
  compile "#{options} #{ESPRESSO_DIR}/#{input} #{APP_DIR}/#{input}" for input in APP_SRC
  compile "#{options} #{ESPRESSO_DIR} #{APP_DIR}/#{ESPRESSO_INDEX}"

buildServer = ->
  options = "-c -b"
  compile "#{options} #{SERVER_FILENAME}"

buildClient = ->

  clientDirs = [
    { output: "#{__dirname}/#{PUBLIC_DIR}/#{ANGULAR_APP_OUT}", input: "#{__dirname}/#{APP_DIR}/#{ANGULAR_APP_SRC}"}
    { output: "#{__dirname}/#{PUBLIC_DIR}/#{CLIENT_RESOURCES_OUT}", input: "#{__dirname}/#{APP_DIR}/#{CLIENT_RESOURCES_SRC}"}
  ]

  for dir in clientDirs
    do (dir) ->
      compile "-c -b -o #{dir.output} #{dir.input}", ->
        uglifyDirectory dir.output

uglifyDirectory = (dir) ->

  console.log "Uglifying #{dir}"

  fs.readdir dir, (err, files) ->
    return if err?
    for file in files
      do (file) ->
        fs.stat "#{dir}/#{file}",
          (err, stats) ->
            if err then throw err
            if stats? and stats.isDirectory()
              uglifyDirectory "#{dir}/#{file}"
            else
              uglifyFile "#{dir}/#{file}"

uglifyFile = (file) ->

  result = uglifyjs.minify "#{file}"
  data = result.code

  fs.writeFile file, data, (err) ->
    if err
      throw err
    console.log "#{file} uglified"


compile = (options, callback) ->
  exec "coffee #{options}", {}, (error, stdout, stderr) ->
    if error
      console.log stderr.toString()
      throw error
    if callback then callback()

deleteEspresso = (callback) ->

  dir = "#{__dirname}/#{ESPRESSO_DIR}"

  deleteDirectory dir, ->
    fs.rmdir dir, (err) ->
      if err
        throw err

  if callback then callback()

deleteClient = (callback) ->

  clientDirs = [
      "#{__dirname}/#{PUBLIC_DIR}/#{ANGULAR_APP_OUT}",
      "#{__dirname}/#{PUBLIC_DIR}/#{CLIENT_RESOURCES_OUT}"
    ]

  for dir in clientDirs
    do (dir) ->
      deleteDirectory dir, ->
        fs.rmdir dir, (err) ->
          if err
            throw err

  if callback then callback()

deleteDirectory = (dir) ->

  fs.readdir dir, (err, files) ->
    return if err?
    for file in files
      do (file) ->
        fs.stat "#{dir}/#{file}",
        (err, stats) ->
          if err then throw err
          if stats? and stats.isDirectory()
            deleteDirectory "#{dir}/#{file}"
          else
            deleteFile "#{dir}/#{file}"

deleteFile = (file) ->
  fs.unlink file, (err) ->
    if err
      throw err


task "build", "Builds app", (callback) ->
  invoke "clean"
  console.log "Building module..."
  buildModule()
  console.log "Building client..."
  buildClient()
  console.log "Building server..."
  buildServer()

task "build:module", "Builds the Espresso module", ->
  invoke "clean:module"
  console.log "Building module..."
  buildModule()
  console.log "Building server..."
  buildServer()

task "build:client", "Builds client scripts", ->
  invoke "clean:client"
  console.log "Building client..."
  buildClient()

task "clean", "Clean module and client", ->
  invoke "clean:module"
  invoke "clean:client"

task "clean:module", "Cleans the Espresso module", ->
  deleteEspresso ->
    console.log "Module cleaned"

task "clean:client", "Cleans the Espresso module", ->
  deleteClient ->
    console.log "Client cleaned"

task "run", "Runs the app", ->
  console.log "App running, press ^C to quit"
  exec "node app", (err, stdout, stderr) ->
    if err
      console.log "Error starting the app. Run 'cake build' to make sure everything's good"
      throw err
