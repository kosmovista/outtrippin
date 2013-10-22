# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.loadAutocomplete = (input) ->
  autocomplete = new google.maps.places.Autocomplete(input[0], {types: ['geocode']})
  google.maps.event.addListener autocomplete, 'place_changed', ->
    $('.' + input.attr('id')).append("<li>" + input.val() + "</li>")

window.disableSubmitOnEnter = (input) ->
  input.keypress (e) ->
    if e.charCode == 13
      return false

$ ->
  # load google autocomplete
  $('.location-autocomplete').each (i, v) ->
    autocomplete = loadAutocomplete($(v))
    disableSubmitOnEnter($(v))

  # prepare form for submission
  # TODO: REFACTOR THIS
  $('#new_expert_registration').submit (e) ->
    cities = []
    countries = []
    $('.expert_registration_expert_info_countries li').each (i, elem) ->
      countries.push $(elem).text()
      countries.push '+'

    $('.expert_registration_expert_info_cities li').each (i, elem) ->
      cities.push $(elem).text()
      cities.push '+'

    $('#expert_registration_expert_info_countries').val(countries)
    $('#expert_registration_expert_info_cities').val(cities)