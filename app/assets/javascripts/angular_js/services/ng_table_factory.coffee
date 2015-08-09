@app.factory 'ngTableFactory', ["$filter", "$http", ($filter, $http) ->
  return (url) ->
    filterData = (data, filter) ->
      $filter('filter')(data, filter)

    orderData = (data, params) ->
      (if params.sorting() then $filter("orderBy")(data, params.orderBy()) else filteredData)

    sliceData = (data, params) ->
      data.slice (params.page() - 1) * params.count(), params.page() * params.count()

    transformData = (data, filter, params) ->
      sliceData orderData(filterData(data, filter), params), params

    factory = {
      cachedData: [],
      data_url: url,
      getData: ($defer, params, filter) ->
        if factory.cachedData.length > 0
          filteredData = filterData(factory.cachedData, filter)
          transformedData = sliceData(orderData(filteredData, params), params)
          params.total filteredData.length
          $defer.resolve transformedData
        else
          $http.get(factory.data_url).success (items) ->
            angular.copy items, factory.cachedData
            params.total items.length
            filteredData = $filter("filter")(items, filter)
            transformedData = transformData(items, filter, params)
            $defer.resolve transformedData
            return
      emptyData: ->
        factory.cachedData = []
        return
      reload: (params) ->
        factory.emptyData()
        params.reload()
    }

    factory
]
