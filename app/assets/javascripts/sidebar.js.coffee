window.showSidebar = ->
  $('.top-logo').hide()
  $('.top-ot').hide()
  $('#guide').hide()
  $('.container').addClass("shrink")
  $('#sidebar').addClass("show")
  

window.hideSidebar = ->
  $('.container').removeClass("shrink")
  $('#sidebar').removeClass("show")
  $('.top-logo').delay(800).fadeIn(200)
  $('.top-ot').delay(800).fadeIn(200)
  $('#guide').delay(800).fadeIn(200)
  

window.act_tab = 0
window.tabbs = $("#cover-tabs").children()

window.tabbs.each (i) ->
  $('#slide' + i + '-content').hide()
  $('#slide' + window.act_tab + '-content').show()
  linkText = $('#slide' + window.act_tab).text()
  $(".tab-dropdown").html(linkText)

  $('#slide' + i).on "click", ->
    $('#slide' + window.act_tab).removeClass("active-tab")
    $('#slide' + window.act_tab + '-content').fadeOut(200)
    # Goto to selected slide
    window.act_tab = i
    linkText = $('#slide' + window.act_tab).text()
    $(".tab-dropdown").html(linkText)
    $('#slide' + window.act_tab).addClass("active-tab")
    $('#slide' + window.act_tab + '-content').delay(200).fadeIn(200)
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
  $(".show-sidebar").on "click", ->
    showSidebar()
    return false

  $(".hide-sidebar").on "click", ->
    hideSidebar()
    return false

  $(".showPitch").on "click", ->
    showPitch()
    return false

  $(".hidePitch").on "click", ->
    hidePitch()
    return false

