window.showSidebar = ->
  $('#sidebar').addClass("active")
  $('.container').css("top", "0")
  $('.container').css("left", "25%")
  $('.container').css("width", "75%")
  $('#sidebar').show()

window.hideSidebar = ->
  $('#sidebar').removeClass("active")
  $('.container').css("top", "0")
  $('.container').css("left", "0")
  $('.container').css("width", "100%")
  $('#sidebar').hide()

window.toogleSidebar = ->
  if $('#sidebar').hasClass("active")
    hideSidebar()
  else
    showSidebar()

$ ->
  $("#toggle-sidebar").on "click", ->
    toogleSidebar()
    return false