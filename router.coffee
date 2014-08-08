Router.map ->
  @route 'discourse_sso',
    path: 'forum/login'
    onBeforeAction: -> @redirect 'login' unless Meteor.loggingIn() || Meteor.user()
    action: ->
      Meteor.call 'discourse_sso', @params, (error, result) ->
        if error then console.log error else @redirect result
