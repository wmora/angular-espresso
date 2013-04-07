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
  Types of source files. DO NOT MODIFY!
###
SOURCES = { COFFEE: "coffee", LESS: "less" }

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
ANGULAR_APP_SRC = "#{__dirname}/#{APP_DIR}/angular"

###
  Client files (static resources) output directory. DO NOT MODIFY!
###
PUBLIC_DIR = "#{__dirname}/public"

###
  Angular app output folder under PUBLIC_DIR
###
ANGULAR_APP_OUT = "#{PUBLIC_DIR}/angular"

###
  Client scripts source folder other than angular files
###
CLIENT_RESOURCES_SRC = "#{APP_DIR}/resources"

###
  Client scripts output folder other than angular files
###
CLIENT_RESOURCES_OUT = "#{PUBLIC_DIR}/js"

###
  Styles source folder
###
STYLES_SRC = "#{__dirname}/styles"

###
  Styles output filename
###
STYLES_NAME = "espresso.css"

###
  Styles output folder
###
STYLES_OUT = "#{PUBLIC_DIR}/styles/#{STYLES_NAME}"

###
  Compiles all APP_SRC directories and into ESPRESSO_DIR
###
buildModule = ->
  options = "-c -b -o"
  compile SOURCES.COFFEE, "#{options} #{ESPRESSO_DIR}/#{input} #{APP_DIR}/#{input}" for input in APP_SRC
  compile SOURCES.COFFEE, "#{options} #{ESPRESSO_DIR} #{APP_DIR}/#{ESPRESSO_INDEX}"


###
  Compiles ESPRESSO_INDEX in the project root
###
buildServer = ->
  options = "-c -b"
  compile SOURCES.COFFEE, "#{options} #{SERVER_FILENAME}"

###
  Compiles and uglifies client dirs
###
buildClient = ->

  clientDirs = [
    {
      type: SOURCES.COFFEE,
      output: "#{ANGULAR_APP_OUT}",
      input: "#{ANGULAR_APP_SRC}"
    },
    {
      type: SOURCES.COFFEE,
      output: "#{CLIENT_RESOURCES_OUT}",
      input: "#{CLIENT_RESOURCES_SRC}"
    },
    {
      type: SOURCES.LESS,
      output: "#{STYLES_OUT}",
      input: "#{STYLES_SRC}"
    }
  ]

  for dir in clientDirs
    do (dir) ->
      switch dir.type
        when SOURCES.COFFEE
          compile dir.type, "-c -b -o #{dir.output} #{dir.input}", ->
            uglifyDirectory dir.output
        when SOURCES.LESS
          compile dir.type, "-x #{dir.input}/* > #{dir.output}"

###
  Uglifies a directory
  @dir - Directory to be uglified
###
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

###
  Uglifies a file
  @file - File to be uglified
###
uglifyFile = (file) ->

  result = uglifyjs.minify "#{file}"
  data = result.code

  fs.writeFile file, data, (err) ->
    if err
      throw err
    console.log "#{file} uglified"

###
  Deletes ESPRESSO_DIR
###
cleanEspresso = (callback) ->

  dir = "#{__dirname}/#{ESPRESSO_DIR}"

  deleteDirectory dir, ->
    fs.rmdir dir, (err) ->
      if err
        throw err

  if callback then callback()

###
  Deletes ANGULAR_APP_OUT, CLIENT_RESOURCES_OUT, and STYLES_OUT
###
cleanClient = (callback) ->

  clientDirs = [
      "#{ANGULAR_APP_OUT}",
      "#{CLIENT_RESOURCES_OUT}",
      "#{STYLES_OUT}"
    ]

  for dir in clientDirs
    do (dir) ->
      deleteDirectory dir, ->
        fs.rmdir dir, (err) ->
          if err then throw err

  if callback then callback()

###
  Deletes a directory
  @dir - Directory to be deleted
###
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

###
  Deletes a file
  @file - File to be deleted
###
deleteFile = (file) ->
  fs.unlink file, (err) ->
    if err
      throw err

###
  Executes a compilation command
  @type - Type of source (SOURCES.COFFEE or SOURCES.LESS)
  @options - Command options
###
compile = (type, options, callback) ->
  switch type
    when SOURCES.COFFEE
      exec "coffee #{options}", {}, (error, stdout, stderr) ->
        if error
          console.log stderr.toString()
          throw error
        if callback then callback()
    when SOURCES.LESS
      exec "lessc #{options}", {}, (error, stdout, stderr) ->
        if error
          console.log stderr.toString()
          throw error
        if callback then callback()

###
  Tasks
###
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
  cleanEspresso ->
    console.log "Module cleaned"

task "clean:client", "Cleans the client", ->
  cleanClient ->
    console.log "Client cleaned"

task "run", "Runs the app", ->
  console.log "App running, press ^C to quit"
  exec "node app", (err, stdout, stderr) ->
    if err
      console.log "Error starting the app. Run 'cake build' to make sure everything's good"
      throw err