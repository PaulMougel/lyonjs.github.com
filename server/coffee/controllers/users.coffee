mongoose = require 'mongoose'

rest = require './rest'
oauth = require '../oauth'

module.exports = (server) ->
  User = mongoose.model 'User'

  server.get '/api/user', (req, res) ->
    oauth.twitter.get 'https://api.twitter.com/1.1/account/verify_credentials.json', req, (error, data, response) ->
      if error?
        console.log 'Twitter response error', error
        res.send null
      else
        data = JSON.parse data
        query = User.find
          twitter: data.screen_name
        query.exec (error, results) ->
          if results.length == 0
            user = new User
              twitter: data.screen_name
            do user.save
        req.session.oauth.token_verify_date = new Date
        console.log 'Twitter response screen name', data.screen_name
        res.send data

  rest server, '/user', User

