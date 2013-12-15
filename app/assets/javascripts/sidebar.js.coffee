window.toogleSidebar = ->
  $('.container').toggleClass("shrink")
  $('#sidebar').toggleClass("show")

window.showPitch = ->
  $('.pitches').animate({
        height: ['show', 'swing']
    }, 1000, 'easeOutBounce')
  $('.showPitch').addClass("active")
  $('.hidePitch').removeClass("active")

window.hidePitch = ->
  $('.pitches').animate({
        height: ['hide', 'swing']
    }, 800, 'easeOutBounce')
  $('.hidePitch').addClass("active")
  $('.showPitch').removeClass("active")

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

