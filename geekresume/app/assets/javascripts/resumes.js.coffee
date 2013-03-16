# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$ ->
  # Выделяет ссылку при фокус на text field
  $("#public_link").focus ->
    $(this).select()
  $("#public_link").mouseup (e) ->
    e.preventDefault()
