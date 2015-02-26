###* Using Rails-like standard naming convention for endpoints.
# * GET     /models              ->  index
# * POST    /models              ->  create
# * GET     /models/:id          ->  show
# * PUT     /models/:id          ->  update
# * DELETE  /models/:id          ->  destroy
###

mongoose = require 'mongoose'
models = require './model'

# exports.list = (req, res) ->
#   models.find()
#   .select 'query_title'
#   .exec (err, data) ->
#     return handleError res, err if err
#     res.status 200
#     .json data

exports.get = (req, res) ->
  _id = new mongoose.Types.ObjectId req.params.id
  models.findById _id
  .exec (err, data) ->
    return handleError res, err if err
    res.status 200
    .json data