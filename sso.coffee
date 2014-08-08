crypto = Npm.require 'crypto'
querystring = Npm.require 'querystring'

class @SingleSignOn extends Minimongoid
  ACCESSORS = ['nonce', 'name', 'email', 'external_id']

  @parse: (params, sso_secret) ->
    sso = @init()
    sso.sso_secret = sso_secret

    throw new Error "Bad signature for payload" unless sso.sign(params.sso) == params.sig

    decoded = (new Buffer params.sso, 'base64').toString()
    decoded_hash = querystring.parse decoded
    _.each ACCESSORS, (k) -> sso[k] = decoded_hash[k]

    sso

  sign: (payload) ->
    crypto.createHmac('sha256', @sso_secret).update(payload).digest('hex')

  to_url: (base_url) ->
    "#{base_url}#{if base_url.match(/\?/) then '&' else '?'}#{@payload()}"

  payload: ->
    payload = new Buffer(@unsigned_payload()).toString('base64')
    "sso=#{encodeURIComponent payload}&sig=#{@sign payload}"

  unsigned_payload: ->
    unsigned_payload = {}

    _.each ACCESSORS, (k) ->
      if val = @[k]
        unsigned_payload[k] = val
    , @

    querystring.stringify unsigned_payload

