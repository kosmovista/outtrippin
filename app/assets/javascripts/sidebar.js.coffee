
window.showSidebar = ->
  $('.container').addClass("shrink")
  $('#sidebar').addClass("show")

window.hideSidebar = ->
  $('.container').removeClass("shrink")
  $('#sidebar').removeClass("show")

window.showPitch = ->
  $('.pitches').animate({
        height: ['show', 'swing']
    }, 1000, 'easeOutBounce');
  $('.showPitch').addClass("active")
  $('.hidePitch').removeClass("active")

window.hidePitch = ->
  $('.pitches').animate({
        height: ['hide', 'swing']
    }, 800, 'easeOutBounce');
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

