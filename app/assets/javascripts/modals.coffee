# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.clear_field = (ids) ->
  index = 0
  while index < ids.length
    $(ids[index]).val ''
    ++index
  $('#error_div').html ''
  return

window.focus_field = (id) ->
  setTimeout (->
    $(id).focus()
    return
  ), 600
  return
