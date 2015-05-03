@app.filter 'trustHtml', ["$sce", ($sce) ->
  (text) ->
    $sce.trustAsHtml text
]

@app.filter 'parseHtml', ["$sce", ($sce) ->
  (text) ->
    $sce.parseAsHtml text
]

@app.filter 'simpleFormat', ["$filter", ($filter) ->
  "use strict"
  linky = $filter 'linky'
  (text) ->
    linky((text || '') + '', "_blank").replace(/\&#10;/g, "&#10;<br>")
]

@app.filter "truncate",[() ->
  (text, length, end) ->
    length = 10  unless length
    end = ""  unless end
    return text  if text.length <= length
    int = text.indexOf(".", length)
    String(text).substring(0, int + 1) + end
]