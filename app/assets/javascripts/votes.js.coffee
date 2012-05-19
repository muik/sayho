$(document).on('ajax:before', '.btn.vote', () ->
  btn = $(this).button('loading')
  vote_id = btn.data('vote-id')
  say_id = btn.data('say-id')
  active_class = btn.data('active-class')

  if btn.hasClass active_class
    btn.data('method', 'delete')
    btn.data('params', null)
  else
    if vote_id
      btn.data('method', 'put')
    else
      btn.data('method', 'post')
    btn.data('params', 'value=' + btn.data('value'))

  if vote_id
    btn.attr('href', '/says/' + say_id + '/votes/' + vote_id + '.json')
  else
    btn.attr('href', '/says/' + say_id + '/votes.json')
)

$(document).on('ajax:error', '.btn.vote', (xhr, status) ->
  $(this).button('reset')
)

$(document).on('vote:unactive', '.btn.vote', () ->
  btn = $(this)
  active_class = btn.data('active-class')
  btn.removeClass active_class
)

$(document).on('ajax:success', '.btn.vote', (event, data, status, xhr) ->
  btn = $(this).button('reset')
  vote_btns = $('.btn.vote', btn.parent('.vote-set')).trigger('vote:unactive')
  active_class = btn.data('active-class')

  if btn.data('method') == 'delete'
    btn.removeClass active_class
    vote_btns.data('vote-id', null)
  else
    btn.addClass active_class
    vote_btns.data('vote-id', data._id)
)
