Meteor.methods
  discourse_sso: (params) ->
    check params, Object

    user = User.first @userId
    throw new Meteor.Error(403, 'Not logged in.') unless user
    throw new Meteor.Error(403, 'Unauthorized.') unless user.is_authorized_to_download_pro()

    sso_secret = process.env.DISCOURSE_SSO_SECRET
    sso = SingleSignOn.parse params, sso_secret
    sso.email = user.email()
    sso.name = user.profile.name if user.profile && user.profile.name
    sso.external_id = user._id
    sso.sso_secret = sso_secret

    sso.to_url "http://privatebeta.spritebuilder.com/session/sso_login"
