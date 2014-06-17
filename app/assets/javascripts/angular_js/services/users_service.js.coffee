@app.service "UsersService", ["$filter", "AdminUser", ($filter, User) ->

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
        users = User.query {}, () ->
          angular.copy users, service.cachedData
          params.total users.length
          filteredData = $filter("filter")(users, filter)
          transformedData = transformData(users, filter, params)
          $defer.resolve transformedData
          return
    emptyData: ->
      service.cachedData = []
      return
    updateUser: (user, params) ->
      up_user = User.update {id:user.id, user:user}, () ->
        service.emptyData()
        params.reload()
      return up_user
    removeUser: (user, params) ->
      User.delete {id:user.id}, ->
        service.emptyData()
        params.reload()
    destroyedUsers: ->
      users = User.query({scope:"destroyed"})
      return users
  }

]