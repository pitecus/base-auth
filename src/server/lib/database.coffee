# Promises library.
Q = require 'q'

mongoose = require 'mongoose'

###
 * ## Connect to this specific MongoDB server
 *
 * @param  {String}  server     The server name
 * @param  {String}  collection The collection name
 *
 * @return {Promise} The promise object
###
connect = (user, pass, server, collection) ->
  deferred = Q.defer()

  connection = mongoose.connection

  connection.on 'connected', ->
    deferred.resolve()

  connection.on 'error', (err) ->
    deferred.reject err

  mongoose.connect 'mongodb://' + user + ':' + pass + '@' + server + '/' + collection,
    server:
      poolSize: 4
      keepAlive: 1

  # Return.
  deferred.promise

disconnect = ->
  deferred = Q.defer()

  console.log 'Quiting mongoose'
  mongoose.connection.close ->
    deferred.resolve()
    return

  # Return.
  deferred.promise

# ## Define the schemas
UserSchema = mongoose.Schema
  'email':
    'type': String
    'index': true
    'unique': true
    'required': true
  'openId':
    'type': String
  'name':
    'type': String
    'required': true
  'status':
    'type': String
    'required': true

ResourceASchema = mongoose.Schema
  # The title is required and must only characters.
  'title':
    'type': String
    'required': true
    'validate': /^[\w ]{1,}$/
  'content':
    'type': String
    'required': true
  'author':
    # Refers to User Schema.
    'id':
      'type': mongoose.Schema.Types.ObjectId
      'required': true
    'name':
      'type': String
      'required': true

# ## Define the models.
User = mongoose.model 'User', UserSchema
ResourceA = mongoose.model 'ResourceA', ResourceASchema

# ## Export the module
module.exports =
  connect: connect
  disconnect: disconnect
  schemas:
    User: UserSchema
    ResourceA: ResourceASchema
  models:
    User: User
    ResourceA: ResourceA