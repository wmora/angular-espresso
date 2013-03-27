app = require "./.espresso"

serverStarted = ->
  console.log "Express server listening on http://#{app.get "ipaddr"}:#{app.get "port"}"

app.listen app.get('port'), app.get('ipaddr'), serverStarted