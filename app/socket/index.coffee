exports.configure = (io) ->

  ###
    Socket.IO config
  ###

  io.on "connection", (socket) ->
    console.log "New socket connected!"

    socket.on "ping", ->
      time = new Date()
      io.sockets.emit "pong", {data: "pong! Time is #{time.toString()}"}
