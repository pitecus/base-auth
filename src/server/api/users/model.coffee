mongoose = require 'mongoose'
Schema = mongoose.Schema

ModelSchema = new Schema
  'provider':
    'type': String
  'identifier':
    'type': String
    'index': true
  'displayName':
    'type': String
  'name':
    'type': String
  'emails': [
    'type':
      'type': String
    'value':
      'type': String
  ]

module.exports = mongoose.model 'User', ModelSchema