Template.discourse_sso.helpers
  user_logged_in: ->
    Meteor.user()

  error: ->
    Session.get('discourse_sso_error')

Template.discourse_sso_error.helpers
  error_message: ->
    Session.get('discourse_sso_error').message

Template.discourse_sso_forum_login.rendered = () ->
  Meteor.call 'discourse_sso', @data.params, (error, result) ->
    if error then Session.set('discourse_sso_error', error) else window.location.href = result
