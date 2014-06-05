@app.filter 'trustHtml', ["$sce", ($sce) ->
  (text) ->
    $sce.trustAsHtml text
]

@app.filter 'simpleFormat', ["$filter", ($filter) ->
  "use strict"
  linky = $filter 'linky'
  (text) ->
    linky((text || '') + '', "_blank").replace(/\&#10;/g, "&#10;<br>")
]