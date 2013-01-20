# workaround to get rid of weird url fragment appended by facebook
# see http://facebook.stackoverflow.com/questions/7131909/facebook-callback-appends-to-return-url
cleanUrlHash = ->
  window.location.hash = '' if window.location.hash == '#_=_'

$(document).ready(cleanUrlHash)
$(document).on('page:load', cleanUrlHash)
