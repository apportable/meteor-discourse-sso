class @SingleSignOn extends Minimongoid
  ACCESSORS = ['nonce', 'name', 'email', 'about_me', 'external_id']

  @parse: (params, sso_secret) ->
    sso = @constructor.init()
    sso.sso_secret = sso_secret

    throw new Error "Bad signature for payload" unless sso.sign(params.sso) == params.sig

    decoded = (new Buffer params.sso, 'base64').toString()
    decoded_hash = querystring.parse decoded # expects decoded not to contain leading '?'
    _.each ACCESSORS, (k) -> sso[k] = decoded_hash[k]

    sso

  sign: (payload) ->
    crypto = require('crypto') # TODO: put somewhere else
    crypto.createHmac('sha256', @sso_secret).update(payload).digest('hex')

  to_url: (base_url) ->
    "#{base_url}#{if base_url.match('?') then '&' else '?'}#{@payload()}"

  payload: ->
    payload = new Buffer(@unsigned_payload()).toString('base64')
    "sso=#{encodeURIComponent payload}&sig=#{@sign payload}"

  unsigned_payload: ->
    unsigned_payload = {}
    _.each ACCESSORS, (k) ->
      if val = @[k]
        unsigned_payload[k] = val

    querystring.stringify unsigned_payload

