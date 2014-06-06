@app.factory "ArrayService", ->
  findInArrayBy: (array, key, value) ->
    flag = false
    angular.forEach array, (item, index) ->
      flag = item if item[key] is value
      return
    flag

  findIndex: (array, key, value) ->
    flag = false
    angular.forEach array, (item, index) ->
      flag = index if item[key] is value
      return
    flag

  splitBy: (string, delimiter) ->
    string.split(delimiter)