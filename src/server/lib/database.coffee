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

# ## Export the module
module.exports =
  'connect': connect
  'disconnect': disconnect