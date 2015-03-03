# Service Session.
define 'auth/session-service', [
  'app'
], (app) ->
  # Load application.
  app.service 'sessionService', [ =>
    @getDisplayName = =>
      return @displayName

    # Store the data.
    @create = (email, displayName) =>
      @email = email
      @displayName = displayName

    # Destroy all the data.
    @destroy = =>
      @email = null
      @displayName = null

    # Return the object.
    return this
  ]