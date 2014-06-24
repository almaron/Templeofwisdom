@app.service "RolesService", ["$filter", "$http", ($filter, $http) ->

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
        $http.get("/admin/roles.json").success (roles) ->
          angular.copy roles, service.cachedData
          params.total roles.length
          filteredData = $filter("filter")(roles, filter)
          transformedData = transformData(roles, filter, params)
          $defer.resolve transformedData
          return
    emptyData: ->
      service.cachedData = []
      return
    reload: (params) ->
      service.emptyData()
      params.reload
  }

]