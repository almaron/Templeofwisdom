@app.factory "News", ["$resource", ($resource) ->
  $resource("/news/:id.json",{id: '@id'}, {update: {method: "PUT"}})
]

@app.factory "BlogPost", ["$resource", ($resource) ->
  $resource("/blog/:id.json",{id:"@id"},{update: {method: "PUT"}})
]

@app.factory "BlogComment", [ "$resource", ($resource) ->
  $resource("/blog/:post_id/comments/:id.json", {post_id: "@post_id", id: "@id"},{update: {method: "PUT"}})
]

@app.factory "currentUser", ["$resource", ($resource) ->
  $resource "/auth/current_user.json", {}
]

@app.factory "GuestPost", ["$resource", ($resource) ->
  $resource("/guestbook/:id.json", {id:"@id"}, {update: {method: "PUT"}, reset:{method: "GET", params:{id: "new"}}})
]

@app.factory "Profile", ["$resource", ($resource) ->
  $resource("/profile.json", {}, {update: {method: "PUT"}})
]

@app.factory "User", ["$resource", ($resource) ->
  $resource("/users/:id.json", {id:"@id"}, {update: {method: "PUT"}})
]

@app.factory "Delegation", ["$resource", ($resource) ->
  $resource "/delegations/:id.json", {id:"@id"}
]

@app.factory "Char", ["$resource", ($resource) ->
  $resource "/chars/:id.json", {id:"@id"}, {update: {method: "PUT"}}
]

