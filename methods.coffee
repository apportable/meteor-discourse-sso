Meteor.methods
  discourse_sso: (params) ->
    check params, Object

    user = User.first @userId
    if !user then return new Meteor.Error # TODO: more verbose error
    if !Roles.userIsInRoles user, 'pro_beta_tester' then return new Meteor.Error # TODO: more verbose error

    sso_secret = "FvJ30dkdLb9aFu8Z62srfwbc"
    sso = SingleSignOn.parse params, sso_secret
    sso.email = user.email()
    sso.name = user.profile.name if user.profile && user.profile.name
    sso.external_id = user._id
    sso.sso_secret = sso_secret

    sso.to_url "http://privatebeta.spritebuilder.com/session/sso_login"
