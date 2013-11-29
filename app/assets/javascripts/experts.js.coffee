window.loadAutocomplete = (input) ->
  autocomplete = new google.maps.places.Autocomplete(input[0], {types: ['geocode']})
  google.maps.event.addListener autocomplete, 'place_changed', ->
    $('.' + input.attr('id')).append("<li>" + input.val() + "<a class='delete' href='#'></a></li>")
    if input.hasClass("add-to-list")
      setTimeout ( ->
        input.val('')
        input.focus()), 1

    $('.delete').on "click", ->
      $(this).parent().remove()
      return false


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
    $('.expert_registration_countries li').each (i, elem) ->
      countries.push $(elem).text()
      countries.push '+'

    $('.expert_registration_cities li').each (i, elem) ->
      cities.push $(elem).text()
      cities.push '+'

    $('#expert_registration_countries').val(countries)
    $('#expert_registration_cities').val(cities)

  $('#new_expert_edit').submit (e) ->
    cities = []
    countries = []
    $('.expert_edit_countries li').each (i, elem) ->
      countries.push $(elem).text()
      countries.push '+'

    $('.expert_edit_cities li').each (i, elem) ->
      cities.push $(elem).text()
      cities.push '+'

    $('#expert_edit_countries').val(countries)
    $('#expert_edit_cities').val(cities)


  # handle errors
  $('.field_with_errors').children().addClass("error")
  $('.field_with_errors').next().removeClass("hide")

  # delete countries / cities from the list
  $('.delete').on "click", ->
    $(this).parent().remove()
    return false