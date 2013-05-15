oauth = require 'oauth'

twitter = new oauth.OAuth(
  'https://api.twitter.com/oauth/request_token',
  'https://api.twitter.com/oauth/access_token',
  '4oiPmiteoQuZAURFO84ZkA',
  'ZPogMD8mXVqQPv3E7XUTsGC7gbn0ZEeS85kOKODbLX0',
  '1.0',
  'http://localhost:1234/auth/twitter/callback',
  'HMAC-SHA1'
)

module.exports.express = (server) ->
  server.get '/auth/twitter', (req, res) ->
    twitter.getOAuthRequestToken (error, oauth_token, oauth_token_secret, results) ->
      if error
        console.log error
        res.send "yeah no. didn't work."
      else
        # if !req.session? then req.session = {}
        req.session.oauth = {}
        req.session.oauth.token = oauth_token
        # console.log 'oauth.token: ', req.session.oauth.token
        req.session.oauth.token_secret = oauth_token_secret
        # console.log 'oauth.token_secret: ', req.session.oauth.token_secret
        res.redirect "https://twitter.com/oauth/authenticate?oauth_token=#{oauth_token}"

  server.get '/auth/twitter/callback', (req, res, next) ->
    if req.session.oauth?
      req.session.oauth.verifier = req.query.oauth_verifier
      twitterOauth = req.session.oauth;

      twitter.getOAuthAccessToken twitterOauth.token, twitterOauth.token_secret, twitterOauth.verifier, (error, oauth_access_token, oauth_access_token_secret, result) ->
        console.log arguments
        if error?
          console.log error
          res.send "yeah something broke."
        else
          req.session.twitter = result.screen_name
          req.session.oauth.access_token = oauth_access_token
          req.session.oauth.access_token_secret = oauth_access_token_secret
          console.log 'Auth Twitter success ', result
          res.redirect 'http://localhost:9000/'
    else
      next new Error "you're not supposed to be here."

module.exports.twitter =
  get: (url, req, callback) ->
    # console.log 'Request Twitter with session', req.session
    if !req.session? or !req.session.oauth?
      console.log 'No session or no authentication'
      callback 'No session or no authentication'
    else
      twitter.get url, req.session.oauth.access_token, req.session.oauth.access_token_secret, (error, data, response) ->
        callback error, data, response