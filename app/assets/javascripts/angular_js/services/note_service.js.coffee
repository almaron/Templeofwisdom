@app.service "NoteService", ["$filter", "$http", ($filter, $http) ->

  filterData = (data, filter) ->
    $filter('filter')(data, filter)

  sliceData = (data, params) ->
    data.slice (params.page() - 1) * params.count(), params.page() * params.count()

  transformData = (data, filter, params) ->
    sliceData filterData(data, filter), params

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
        $http.get('/notifications.json').success (notes) ->
          angular.copy notes, service.cachedData
          params.total notes.length
          filteredData = $filter("filter")(notes, filter)
          transformedData = transformData(notes, filter, params)
          $defer.resolve transformedData
          return
    emptyData: ->
      service.cachedData = []
      return
    removeNote: (note, params) ->
      $http.delete('/notifications/'+note.id+'.json').success ->
        service.cachedData.splice(service.cachedData.indexOf(note),1)
        params.reload
    readNote: (note) ->
      service.cachedData[service.cachedData.indexOf(note)].read = true
  }

]