
window.showSidebar = ->
  $('.container').addClass("shrink")
  $('#sidebar').addClass("show")

window.hideSidebar = ->
  $('.container').removeClass("shrink")
  $('#sidebar').removeClass("show")

window.showPitch = ->
  $('.pitches').addClass("showall")
  $('.showPitch').addClass("active")
  $('.hidePitch').removeClass("active")

window.hidePitch = ->
  $('.pitches').removeClass("showall")
  $('.hidePitch').addClass("active")
  $('.showPitch').removeClass("active")


window.toogleSidebar = ->
  if $('#sidebar').hasClass("show")
    hideSidebar()
  else
    showSidebar()

$ ->
  $(".toggle-sidebar").on "click", ->
    toogleSidebar()
    return false

  $(".showPitch").on "click", ->
    showPitch()
    return false

  $(".hidePitch").on "click", ->
    hidePitch()
    return false

