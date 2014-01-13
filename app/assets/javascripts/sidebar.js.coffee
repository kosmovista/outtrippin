window.toogleSidebar = ->
  $('.container').toggleClass("shrink")
  $('#sidebar').toggleClass("show")
  $("#guide").toggle()

window.showPitch = ->
  $('.pitches').animate({
        height: ['show', 'swing']
    }, 1000, 'easeOutBounce')
  $('.showPitch').addClass("active-tab")
  $('.hidePitch').removeClass("active-tab")

window.hidePitch = ->
  $('.pitches').animate({
        height: ['hide', 'swing']
    }, 800, 'easeOutBounce')
  $('.hidePitch').addClass("active-tab")
  $('.showPitch').removeClass("active-tab")

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

