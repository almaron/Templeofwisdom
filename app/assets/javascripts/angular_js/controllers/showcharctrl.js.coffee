@app.controller "ShowCharCtrl", [ "$scope", "$http", "Char", ($scope, $http, Char) ->

  $scope.loadChar = (char_id) ->
    $scope.char = Char.get {id: char_id}

]