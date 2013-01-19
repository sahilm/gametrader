# workaround to get rid of weird url fragment appended by facebook
# see http://facebook.stackoverflow.com/questions/7131909/facebook-callback-appends-to-return-url
ready = ->
    if window.location.hash == '#_=_'
      window.location.hash = ''

$(document).ready(ready)
$(document).on('page:load', ready)
