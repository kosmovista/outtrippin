window.enterEditionMode = (obj) ->
  obj.text("")
  obj.unbind()

window.leaveEditionMode = (obj, name, personal_info) ->
  $(obj).on "click", ->
    makeEditable(obj, name, personal_info)

window.makeEditable = (obj, name, personal_info = false) ->
  previous_text = obj.text().trim()
  if personal_info
    input = $("<input name='personal_info[#{name}]' value='#{previous_text}' type='text'/>")
  else
    input = $("<input name='expert_info[#{name}]' value='#{previous_text}' type='text'/>")
  enterEditionMode(obj)
  input.appendTo(obj)
  input.keypress (e) ->
    if e.charCode == 13
      $.ajax '/expert',
        type: 'PUT'
        dataType: 'json'
        data: obj.find('input').serialize()
        error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call: #{data}"
          obj.empty()
          obj.append("<span><a href='#'></a>#{data[name]}</span>")
          leaveEditionMode(obj, name, personal_info)

$ ->
  $('.edit-name-inline a').on "click", (e) ->
    e.preventDefault()
    makeEditable($(this).parent().parent(), "name", true)

  $('.edit-bio-inline a').on "click", (e) ->
    e.preventDefault()
    makeEditable($(this).parent().parent(), "bio")

  $('.edit-story-inline a').on "click", (e) ->
    e.preventDefault()
    makeEditable($(this).parent().parent(), "story")

  $('.edit-travel_hack-inline a').on "click", (e) ->
    e.preventDefault()
    makeEditable($(this).parent().parent(), "travel_hack")

  $('.edit-hometown-inline a').on "click", (e) ->
    e.preventDefault()
    makeEditable($(this).parent().parent(), "hometown")

  $('.edit-location-inline a').on "click", (e) ->
    e.preventDefault()
    makeEditable($(this).parent().parent(), "location")
