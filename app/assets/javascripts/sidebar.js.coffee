window.toogleSidebar = ->
  $('.top-logo').toggle()
  $('.container').toggleClass("shrink")
  $('#sidebar').toggleClass("show")
  $("#guide").toggle()

window.act_tab = 0
window.tabbs = $("#cover-tabs").children()

window.tabbs.each (i) ->
  $('#slide' + i + '-content').hide()
  $('#slide' + window.act_tab + '-content').show()

  $('#slide' + i).on "click", ->
    $('#slide' + window.act_tab).removeClass("active-tab")
    $('#slide' + window.act_tab + '-content').toggle()
    # Goto to selected slide
    window.act_tab = i
    $('#slide' + window.act_tab).addClass("active-tab")
    $('#slide' + window.act_tab + '-content').toggle()
    return false



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

