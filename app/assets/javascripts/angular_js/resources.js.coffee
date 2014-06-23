@app.factory "News", ["$resource", ($resource) ->
  $resource(
    "/news/:id.json",
    {
      id: '@id'
    },
    {
      update: {method: "PUT"},
      get_total:{method:"GET", params:{get_total:true}}
    }
  )
]

@app.factory "BlogPost", ["$resource", ($resource) ->
  $resource("/blog/:id.json",{id:"@id"},{update: {method: "PUT"}, get_total:{method:"GET", params:{get_total:true}}})
]

@app.factory "BlogComment", [ "$resource", ($resource) ->
  $resource("/blog/:post_id/comments/:id.json", {post_id: "@post_id", id: "@id"},{update: {method: "PUT"}})
]

@app.factory "currentUser", ["$resource", ($resource) ->
  $resource "/auth/current_user.json", {}
]

@app.factory "GuestPost", ["$resource", ($resource) ->
  $resource(
    "/guestbook/:id.json",
    {
      id:"@id"
    },
    {
      update: {method: "PUT"},
      reset:{method: "GET", params:{id: "new"}},
      get_total:{method:"GET", params:{get_total:true}}
    }
  )
]

@app.factory "Profile", ["$resource", ($resource) ->
  $resource("/profile.json", {}, {update: {method: "PUT"}})
]

@app.factory "User", ["$resource", ($resource) ->
  $resource("/users/:id.json", {id:"@id"}, {update: {method: "PUT"}})
]

@app.factory "AdminUser", ["$resource", ($resource) ->
  $resource("/admin/users/:id.json", {id:"@id"}, {update: {method: "PUT"}})
]

@app.factory "Delegation", ["$resource", ($resource) ->
  $resource "/delegations/:id.json", {id:"@id"}
]

@app.factory "Char", ["$resource", ($resource) ->
  $resource "/chars/:id.json", {id:"@id"}, {update: {method: "PUT"}}
]

@app.factory "AdminChar", ["$resource", ($resource) ->
  $resource "/admin/chars/:id.json", {id:"@id"}, {update: {method: "PUT"}}
]

@app.factory "Config", ["$resource", ($resource) ->
  $resource "/admin/configs/:id.json", {id:"@id"}, {update: {method: "PUT"}}
]

@app.factory "Forum", ["$resource", ($resource) ->
  $resource "/temple/:id.json", {id:"@id"}
]

@app.factory "AdminForum", ["$resource", ($resource) ->
  $resource "/admin/forums/:id.json", {id:"@id"}, {update: {method: "PUT"}}
]


@app.factory "Topic", ["$resource", ($resource) ->
  $resource "/temple/:forum_id/t/:id.json", {forum_id:"@forum_id", id:"@id"}, {update: {method: "PUT"}}
]

@app.factory "Post", ["$resource", ($resource) ->
  $resource "/temple/:forum_id/t/:topic_id/p/:id.json", {forum_id:"@forum_id", topic_id:"@topic_id", id:"@id"}, {update: {method: "PUT"}}
]