socket = io.connect document.domain

console.log socket

socket.on "connect", ->
  console.log "Connected"

