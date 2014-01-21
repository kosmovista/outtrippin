# SET COVER HEIGHT 
window.active_bg = 0
window.images = $("#image-loader").children()
window.experts = $("#expert-loader").children()

bulletNav = $("<ul>"
    class: "inline-list cover-bullets"
  ).appendTo(".navig")

# Create a list item and anchor for each slide
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
  image = window.images[window.active_bg].src
  expert = window.experts[window.active_bg]
  jQuery(window.experts).fadeOut(10, 'easeInQuad')
  $('#slide' + window.active_bg).addClass("act")
  $("#destinations").css("background", "url('" + image + "') no-repeat center center")
  jQuery(expert).fadeIn(100, 'easeOutQuad')

# SCROLL DOWN
window.scrollDown = ->
  $('html, body').animate({
    scrollTop: $("#steps").offset().top
  }, 1000, 'easeOutQuart')


######################
# AFTER WINDOW LOADS #
######################



$("#scroll-down").on "click", ->
    scrollDown()
    return false

$(window).resize ->
  $('.home-cover').css("height", $(window).height())  

$(window).load ->
  $('.home-cover').css("height", $(window).height())
  autocomplete = new google.maps.places.Autocomplete(document.getElementById('itinerary_destination'), {types: ['geocode']})
  setBg()
  $("#header").show()
  $("#sub-header").show()
  $("#dest").show()
  $("#contestbtn").show()
  $("#loading").delay(200).fadeOut(100, 'easeOutQuad')
  $("#scroll-down").delay(1000).fadeIn(100, 'easeOutQuad')