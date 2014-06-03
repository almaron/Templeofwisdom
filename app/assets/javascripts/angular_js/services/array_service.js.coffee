@app.factory "ArrayService", ->
  findInArrayBy: (array, key, value) ->
    flag = false
    angular.forEach array, (item, index) ->
      flag = item if item[key] is value
      return
    flag