
###
  GET home page
###

exports.index = (request, response) ->
  response.render "index"

###
  GET partial templates
###

exports.partials = (request, response) ->
  response.render "partials/" + request.params.name