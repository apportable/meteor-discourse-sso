Router.map ->
  @route 'discourse_sso',
    path: 'forum/login'
    onBeforeAction: -> Session.set 'discourse_sso_error', null
    data: ->
      params:
        sso: @params.sso
        sig: @params.sig
