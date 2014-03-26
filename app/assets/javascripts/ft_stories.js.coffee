#SET BROWSE TRIP VARIABLES
window.active_trip = 0
window.covers = $("#trip-loader").children()
window.details = $("#detail-loader").children()
tripCount = $("#trip-loader").children().length

rotateTrip = ''

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
  if (typeof window.covers[window.active_trip] != 'undefined')
    cover = window.covers[window.active_trip].src
  else
    cover = ''
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
 return false

######################
# AFTER WINDOW LOADS #
######################
$(window).resize ->
$('#featuring').css("height", $(window).height())

$(window).ready ->
  $('#featuring').css("height", $(window).height())
  changeTrip()
  $("#loading").hide()
  $("#detail-loader").show()
