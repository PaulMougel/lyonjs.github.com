mongoose = require 'mongoose'

module.exports = (server, route, model) ->
  if route? and model?
    server.get route, (req, res) ->
      console.log 'rest get'
      model.find {}, (err, docs) ->
        res.send docs

    server.put route, (req, res) ->
      model.remove {}, ->
        model.insert req.body, (err, doc) ->
          res.send(doc)

    server.post route, (req, res) ->
      model.remove {}, ->
        model.insert req.body, (err, doc) ->
          res.send(doc)

    server.delete route, (req, res) ->
      model.remove {}, ->
        res.send 200