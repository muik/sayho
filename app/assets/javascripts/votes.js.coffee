$(document).on('ajax:before', '.btn.vote', () ->
  btn = $(this).button('loading')
  active_class = btn.data('active-class')
  if btn.hasClass active_class
    btn.data('method', 'delete')
  else
    btn.data('method', 'post')
  btn.data('params', 'value=' + btn.data('value'))
)

$(document).on('ajax:error', '.btn.vote', (xhr, status) ->
  $(this).button('reset')
)

$(document).on('vote:unactive', '.btn.vote', () ->
  btn = $(this)
  active_class = btn.data('active-class')
  btn.removeClass active_class
)

$(document).on('ajax:success', '.btn.vote', (xhr, status) ->
  btn = $(this).button('reset')
  set = btn.parent('.vote-set')
  $('.btn.vote', set).trigger('vote:unactive')

  method = btn.data('method')
  active_class = btn.data('active-class')
  if method == 'post'
    btn.addClass active_class
  else
    btn.removeClass active_class
)
