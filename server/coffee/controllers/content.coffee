_ = require 'underscore'
mongoose = require 'mongoose'

Content = mongoose.model 'Content'

module.exports = (server) ->
  server.get '/api/content/:key', (req, res) ->
    ## console.log req
    Content.findOne { key: req.params.key } , (err, doc) ->
      if doc?
        res.send doc
      else
        res.send
          key: req.params.key
          content: ''


  server.post '/api/content/:key', (req, res) ->
    Content.findOne { key: req.params.key } , (err, content) ->
      if content?
        _.extend content, req.body
      else
        content = new Content req.body
      do content.save