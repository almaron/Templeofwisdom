@app.service "CharsService", ["$filter", "AdminChar", ($filter, Char) ->

  filterData = (data, filter) ->
    $filter('filter')(data, filter)

  orderData = (data, params) ->
    (if params.sorting() then $filter("orderBy")(data, params.orderBy()) else filteredData)

  sliceData = (data, params) ->
    data.slice (params.page() - 1) * params.count(), params.page() * params.count()

  transformData = (data, filter, params) ->
    sliceData orderData(filterData(data, filter), params), params

  service = {
    cachedData: []
    getData: ($defer, params, filter) ->
      if service.cachedData.length > 0
        console.log "using cached data"
        filteredData = filterData(service.cachedData, filter)
        transformedData = sliceData(orderData(filteredData, params), params)
        params.total filteredData.length
        $defer.resolve transformedData
      else
        chars = Char.query {}, () ->
          angular.copy chars, service.cachedData
          params.total chars.length
          filteredData = $filter("filter")(chars, filter)
          transformedData = transformData(chars, filter, params)
          $defer.resolve transformedData
          return
    emptyData: ->
      service.cachedData = []
      return
    reload: (params)->
      service.emptyData()
      params.reload()
    updateChar: (char, params) ->
      up_char = Char.update {id:char.id, char:char}, () ->
        service.emptyData()
        params.reload()
      return up_char
    removeChar: (char, params) ->
      Char.delete {id:char.id}, ->
        service.emptyData()
        params.reload()
  }

]