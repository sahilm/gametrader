ready = ->
  gameTrader =
    textbox: $('#game_name')
    minLength: 3
  opts =
    minLength: gameTrader.minLength
    items: 8
    source: (query, process) ->
      isNew = (query) ->
        return false unless query
        return true unless gameTrader.query
        newq = query[..gameTrader.minLength-1]
        oldq = gameTrader.query[..gameTrader.minLength-1]
        oldq != newq

      if isNew(query)
        gameTrader.query = query
        $.getJSON(gameTrader.textbox.data('url'), (data) ->
          console.log('fetching...')
          gameTrader.data = data
          process(data))
      else
        gameTrader.data

  gameTrader.textbox.typeahead(opts)
$(document).ready(ready)
$(document).on('page:load', ready)
