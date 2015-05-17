@app.factory "ArrayService", ->

  findBy: (array, key, value) ->
    found = []
    angular.forEach array, (item, index) ->
      found.push item if item[key] is value
    return false if found.length == 0
    return found[0] if found.length == 1
    found


  findIndex: (array, key, value) ->
    flag = false
    angular.forEach array, (item, index) ->
      flag = index if item[key] is value
      return
    flag

  splitBy: (string, delimiter) ->
    string.split(delimiter)