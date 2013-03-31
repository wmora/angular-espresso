exports.setEnv = (environment) ->

  ###
    Common config
  ###
  exports.HOSTNAME = "localhost"
  exports.PORT = 8080
  exports.PUBLIC_PATH = "public"
  exports.VIEWS_ENGINE = "jade"
  exports.VIEWS_PATH = "views"
  exports.IMAGES_PATH = "images"

  ###
    Environment specific config
  ###
  switch environment
    when "development"
      null

    when "testing"
      null

    when "production"
      null

    else
      console.log "Unknown environment #{environment}!"
