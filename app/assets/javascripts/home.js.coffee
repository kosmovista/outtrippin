window.active_bg = 0
window.images = $("#image-loader").children()
window.experts = $("#expert-loader").children()


# NEXT BACKGROUND
window.nextBg = ->
  if window.active_bg == window.images.length - 1
    window.active_bg = 0
  else
    window.active_bg = window.active_bg + 1
  setBg()

# PREVIOUS BACKGROUND
window.prevBg = ->
  if window.active_bg == 0
    window.active_bg = window.images.length - 1
  else
    window.active_bg = window.active_bg - 1
  setBg()

# SET BACKGROUND
window.setBg = ->
  image = window.images[window.active_bg].src
  expert = window.experts[window.active_bg]
  jQuery(window.experts).hide()
  $("#destinations").css("background", "url('" + image + "') no-repeat center center fixed")
  jQuery(expert).show("fade")


######################
# AFTER WINDOW LOADS #
######################
$(window).load ->
  autocomplete = new google.maps.places.Autocomplete(document.getElementById('itinerary_destination'), {types: ['geocode']})

  $("#loading").hide()
  setBg()
  $("#header").show("fade")


  $("#left").bind "click", ->
    prevBg()
    return false

  $("#right").bind "click", ->
    nextBg()
    return false
