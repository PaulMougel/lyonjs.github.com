mongoose = require 'mongoose'

rest = require './rest'
oauth = require '../oauth'

module.exports = (server) ->
  User = mongoose.model 'User'

  server.get '/api/user', (req, res) ->
    console.log 'GET user', req.session
    User.findOne(twitter: req.session.twitter).exec (err, user) ->
      console.log 'GET user', user
      if user?.twitterData?
        console.log 'GET user return twitter data from Mongo'
        res.send user.twitterData
      else
        console.log 'GET user verify twitter account'
        oauth.twitter.get 'https://api.twitter.com/1.1/account/verify_credentials.json', req, (error, data, response) ->
          if error?
            console.log 'GET user verify twitter failed :', error
            res.send null
          else
            data = JSON.parse data
            if user?
              console.log 'GET user enhanced user with twitter data'
              user.twitterData = data
            else
              console.log 'GET user create user with twitter data'
              user = new User
                twitter: data.screen_name
            do user.save
            res.send data

  server.get '/api/user/:screen_name', (req, res) ->
    console.log 'GET user ', req.params.screen_name
    oauth.twitter.get "https://api.twitter.com/1.1/users/show.json?screen_name=#{req.params.screen_name}", req, (error, data, response) ->
      res.send data

  rest server, '/user', User

