###
  Module dependencies.
###

config = require "./config"
express = require "express"
routes = require "./routes"
path = require "path"

app = express()

###
  Configuration
###

app.configure "development", "testing", "production", ->
  config.setEnv app.settings.env

app.set "ipaddr", config.HOSTNAME
app.set "port", config.PORT
app.set "views", path.join process.cwd(), config.VIEWS_PATH
app.set "view engine", config.VIEWS_ENGINE
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express["static"] path.join process.cwd(), config.PUBLIC_PATH

###
  Routes
###

app.get "/", routes.index
app.get "/partials/:name", routes.partials

###
  Export app
###

module.exports = app