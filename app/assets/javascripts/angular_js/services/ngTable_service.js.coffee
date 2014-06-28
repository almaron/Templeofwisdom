@app.service "ngTableService", ["$filter", "$http", ($filter, $http) ->

  filterData = (data, filter) ->
    $filter('filter')(data, filter)

  orderData = (data, params) ->
    (if params.sorting() then $filter("orderBy")(data, params.orderBy()) else filteredData)

  sliceData = (data, params) ->
    data.slice (params.page() - 1) * params.count(), params.page() * params.count()

  transformData = (data, filter, params) ->
    sliceData orderData(filterData(data, filter), params), params

  service = {
    cachedData: [],
    data_url: '',
    setUrl: (data_url) ->
      service.data_url = data_url
    getData: ($defer, params, filter) ->
      if service.cachedData.length > 0
        filteredData = filterData(service.cachedData, filter)
        transformedData = sliceData(orderData(filteredData, params), params)
        params.total filteredData.length
        $defer.resolve transformedData
      else
        $http.get(service.data_url).success (items) ->
          angular.copy items, service.cachedData
          params.total items.length
          filteredData = $filter("filter")(items, filter)
          transformedData = transformData(items, filter, params)
          $defer.resolve transformedData
          return
    emptyData: ->
      service.cachedData = []
      return
    reload: (params) ->
      service.emptyData()
      params.reload()
  }

]