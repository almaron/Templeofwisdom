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