###
  Module dependencies.
###

express = require "express"
routes = require "./routes"
path = require("path")

app = express()

###
  Configuration
###

app.set "ipaddr", process.env.IP_ADDR || "127.0.0.1"
app.set "port", process.env.PORT || 3000
app.set "views", process.cwd() + "/views"
app.set "view engine", "jade"
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express["static"](path.join(process.cwd(), "public"))

developmentConfig = ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure "development", developmentConfig

prodConfig = ->
  app.use express.errorHandler()

app.configure "production", prodConfig

###
  Routes
###
app.get "/", routes.index
app.get "/partials/:name", routes.partials


###
  aaaand GO!
###

serverStarted = ->
  console.log "Express server listening on http://#{app.get "ipaddr"}:#{app.get "port"}"

app.listen app.get('port'), app.get('ipaddr'), serverStarted
