winston = require 'winston'

moment = require 'moment'

# ## Export the module
module.exports = (filename) ->
  _moduleName = filename.split '/'
    .pop()
    .replace /.js$/, ''

  logger = new (winston.Logger)

  # Log in the console.
  logger.add winston.transports.Console,
    level: 'silly'
    prettyPrint: false
    colorize: true
    silent: false
    timestamp: ->
      return '[' + moment().format('HH:mm:ss.SSS') + '] [' + _moduleName + ']'

  # Log in the file.
  logger.add winston.transports.File,
    filename: '../../base-auth.log'
    level: 'silly'
    prettyPrint: false
    colorize: false
    silent: false
    json: false
    timestamp: ->
      return '[' + moment().format('HH:mm:ss.SSS') + '] [' + _moduleName + ']'


  profiling = []
  profileStart = (id) ->
    # Remove existing entries.
    if profiling.length > 0
      for i in [0..profiling.length - 1]
        if profiling[i]._id == id
          logger.error 'profiling another process with same id:', id

          # Failed to start profiling due to duplicated entries
          return false
          break

    # Add new entry.
    now = Date.now()
    profiling.push
      _id: id
      _start: now
      _step: now
      _steps:
        start: now

    # Notify that profiling is started.
    return true

  profileEnd = (id) ->
    now = Date.now()
    found = null
    # Remove existing entries.
    if profiling.length > 0
      for i in [0..profiling.length - 1]
        if profiling[i]._id == id
          found = profiling.splice i, 1
          found = found[0]
          break

    found._steps.duration = now - found._start if found != null

    return {
      id: id
      steps: found?._steps
    }

  profileStep = (id, stepId) ->
    now = Date.now()
    for i in profiling
      if i._id == id
        i._steps[stepId] = now - i._step
        i._step = now
        break

  # Return
  trace: logger.silly
  debug: logger.debug
  info: logger.info
  warn: logger.warn
  error: logger.error
  profileStart: profileStart
  profileStep: profileStep
  profileEnd: profileEnd