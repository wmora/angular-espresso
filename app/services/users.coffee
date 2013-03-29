user1 = { id: "1", name: "John Doe", email: "jodoe@email.com" }
user2 = { id: "2", name: "Jane Doe", email: "jadoe@email.com" }
users = [user1, user2]

user = module.exports = {

list: (request, response) ->
  ###
    List all users
  ###
  response.json 200, { message: users }
,
get: (request, response) ->
  ###
    Return a single user
  ###
  id = request.params.id
  if not id
    return response.json 400, {error: "Missing user id"}

  switch id
    when "1"
      return response.json 200, {user: user1}
    when "2"
      return response.json 200, {user: user2}
    else
      return response.json 404, {error: "User not found"}
}