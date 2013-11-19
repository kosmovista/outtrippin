window.showSidebar = ->
  $('.container').addClass("shrink")
  $('#sidebar').addClass("show")

window.hideSidebar = ->
  $('.container').removeClass("shrink")
  $('#sidebar').removeClass("show")

window.toogleSidebar = ->
  if $('#sidebar').hasClass("show")
    hideSidebar()
  else
    showSidebar()

$ ->
  $(".toggle-sidebar").on "click", ->
    toogleSidebar()
    return false