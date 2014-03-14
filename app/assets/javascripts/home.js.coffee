# SET COVER VARIABLES
window.active_bg = 0
window.images = $("#image-loader").children()
window.experts = $("#expert-loader").children()
bgCount = $("#image-loader").children().length

rotateBg = ''

# HOME PAGE COVER
bulletNav = $("<ul>"
    class: "inline-list cover-bullets"
  ).appendTo(".navig")

# HOME PAGE COVER BULLETS
window.images.each (i) ->
  bulletItem = $("<li>"
    class: "bullet-item"
  ).appendTo(bulletNav)

  bulletLink = $("<a>"
    href: "#"
    id: "slide" + i
  ).appendTo(bulletItem)

  # bind click events
  bulletLink.on "click", ->
    $('#slide' + window.active_bg).removeClass("act")
    # Goto to selected slide
    window.active_bg = i
    setBg()
    return false

# SET BACKGROUND
window.setBg = ->
  clearTimeout(rotateBg)
  if (typeof window.images[window.active_bg] != 'undefined')
    image = window.images[window.active_bg].src
  else
    image = ''
  expert = window.experts[window.active_bg]
  jQuery(window.experts).hide()
  $('#slide' + window.active_bg).addClass("act")
  $("#destinations").css("background", "url('" + image + "') no-repeat center center")
  jQuery(expert).show()
  rotateBg = setTimeout(nextBg, 6000)
  

# NEXT BG
window.nextBg = ->
 $('#slide' + window.active_bg).removeClass("act")
 if window.active_bg == bgCount-1
  window.active_bg = 0
 else
  window.active_bg++
 setBg()

# SCROLL DOWN
window.scrollDown = ->
  $('html, body').animate({
    scrollTop: $("#steps").offset().top
  }, 1000, 'easeOutQuart')

# SCROLL UP
window.scrollUp = ->
  $('html, body').animate({
    scrollTop: 0
  }, 2000, 'easeOutQuart')


######################
# AFTER WINDOW LOADS #
######################

$(window).on "scroll", ->
  $('.top-logo').css( "display", "none" ).fadeIn(200);
  $('.top-ot').css( "display", "none" ).fadeIn(200);
  $('#guide').css( "display", "none" ).fadeIn(200);
  return false

$("#scroll-down").on "click", ->
    scrollDown()
    return false

$("a[href='#scroll-up']").on "click", ->
    scrollUp()
    return false

$(window).resize ->
  $('.home-cover').css("height", $(window).height())

$(window).load ->
  $('.home-cover').css("height", $(window).height())
  $("#dest").show()
  $("#header").show()
  $("#sub-header").show()
  $("#contestbtn").show()
  $("#loading").hide()
  $("#scroll-down").delay(100).fadeIn(100, 'easeOutQuad')
  setBg()

