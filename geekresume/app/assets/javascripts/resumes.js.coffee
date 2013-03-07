# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$ ->
  editor = ace.edit("editor")
  editor.setTheme("ace/theme/twillight")
  editor.getSession().setMode("ace/mode/markdown")

  # Скрываем textarea для формы и изменяем ее на лету
  textarea = $('textarea#resume_content').hide()
  editor.getSession().setValue(textarea.val())
  editor.getSession().on 'change', ->
    textarea.val(editor.getSession().getValue())
