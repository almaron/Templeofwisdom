@app.filter "cut_tree", ["$filter", ($filter) ->
  (tree) ->
    newTree = []
    angular.forEach tree, (node, index) ->
      newNode = {
        id: node.id,
        sort_order: index,
        children: $filter('cut_tree')(node.children)
      }
      newTree.push newNode
]

@app.filter "level_tree", ["$filter", ($filter) ->
  (tree, parent = null) ->
    stack = []
    angular.forEach tree, (node, index) ->
      newNode = {
        id:node.id,
        sort_order: index,
        parent_id: parent
      }
      stack.push newNode
      angular.forEach $filter('level_tree')(node.children, node.id, stack), (item) ->
        stack.push item
    return stack
]