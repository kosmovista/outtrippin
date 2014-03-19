# SET COVER VARIABLES
window.active_bg = 0
window.images = $("#image-loader").children()
window.experts = $("#expert-loader").children()
bgCount = $("#image-loader").children().length

rotateBg = ''

#SET BROWSE TRIP VARIABLES
window.active_trip = 0
window.covers = $("#trip-loader").children()
window.details = $("#detail-loader").children()
tripCount = $("#trip-loader").children().length

rotateTrip = ''

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
  image = window.images[window.active_bg].src
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

# BROWSE TRIPS
featureNav = $("<ul>"
    class: "inline-list browse-bullets"
  ).appendTo(".navigate")

# BROWSE TRIPS BULLETS
if window.covers
  window.covers.each (i) ->
    tripItem = $("<li>"
      class: "trip-item"
    ).appendTo(featureNav)

    tripLink = $("<a>"
      href: "#"
      id: "tripNo" + i
    ).appendTo(tripItem)

  # bind click events
    tripLink.on "click", ->
      $('#tripNo' + window.active_trip).removeClass("act1")
      # Goto to selected slide
      window.active_trip = i
      changeTrip()
      return false

# SET TRIP
window.changeTrip = ->
  clearTimeout(rotateTrip)
  cover = window.covers[window.active_trip].src
  detail = window.details[window.active_trip]
  jQuery(window.details).fadeOut(0, 'easeInQuad')
  $('#tripNo' + window.active_trip).addClass("act1")
  $(".trip").css("background", "url('" + cover + "') no-repeat center center")
  jQuery(detail).fadeIn(0, 'easeOutQuad')
  rotateTrip = setTimeout(nextTrip, 6000)

# NEXT TRIP
window.nextTrip = ->
 $('#tripNo' + window.active_trip).removeClass("act1")
 if window.active_trip == tripCount-1
  window.active_trip = 0
 else
  window.active_trip++
 changeTrip()

# SCROLL DOWN
window.scrollDown = ->
  $('html, body').animate({
    scrollTop: $("#steps").offset().top
  }, 1000, 'easeOutQuart')

# SCROLL UP
window.scrollUp = ->
  $('html, body').animate({
    scrollTop: $(".home-cover").offset().top
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

$("#scroll-up").on "click", ->
    scrollUp()
    return false

$(window).resize ->
  $('.home-cover').css("height", $(window).height())
  $('#featuring').css("height", $(window).height())

$(window).load ->
  $('.home-cover').css("height", $(window).height())
  $("#dest").show()
  $("#header").show()
  $("#sub-header").show()
  $("#contestbtn").show()
  $("#scroll-down").delay(100).fadeIn(100, 'easeOutQuad')
  setBg()
  $('#featuring').css("height", $(window).height())
  changeTrip()
