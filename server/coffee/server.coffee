sourceMap = require 'source-map-support'
mongoose = require 'mongoose'
express = require 'express'
fs = require 'fs'
_ = require 'underscore'

cors = require './cors'
oauth = require './oauth'

# SourceMap
do sourceMap.install

# Mongoose connect
mongoose.set 'debug', true
mongoose.connection.on 'error', console.error.bind console, 'connection error:'
mongoose.connect 'mongodb://localhost/test'

# Mongoose schemas
require './schema'

# Express configuration
server = do express

# JSON parser, Cookie parser, Cookie session
server.use do express.bodyParser
server.use do express.cookieParser
server.use express.cookieSession
  key: 'francejs'
  secret:'francejssecret'

# Cross Domain plugin
server.use cors

# Static files
server.use express.static __dirname + '/../public'

# Adding OAuth routes
oauth.express server

# Adding application's controllers
controllers = fs.readdirSync './js/controllers'
_.each controllers, (file) ->
  if ((file.indexOf '.js') == file.length - 3)
    controller = require "./controllers/#{file}"
    controller server

# If the server root is requested, we respond with the description of routes avalaible
server.get '/', (req, res) ->
  res.send server.routes

# Starting server
server.listen 1234

console.log 'Server listening on port ' + 1234
