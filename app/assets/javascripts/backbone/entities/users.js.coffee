@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.User extends Entities.Model
    urlRoot: -> Routes.users_path()

    setUpApiKeys: ->
      @api_keys = App.request "create:api_keys", @get("api_keys"), @id.$oid

  class Entities.CurrentUser extends Entities.User
    urlRoot: -> "#{Routes.users_path()}/me"

  API=
    getCourse: (id) ->
      user = new Entities.User
        id: id
      user.fetch()
      user

    newUser: ->
      new Entities.User

    currentUser:(fetch) ->
      if  !(App.currentUser) || fetch
        App.currentUser ?= new Entities.CurrentUser
        App.currentUser.fetch().done ->
          App.currentUser.setUpApiKeys()

      App.currentUser

    resetCurrentUser: ->
      App.currentUser = null

    setCurrentUser: (user) ->
      currentUser = new Entities.CurrentUser(user)
      App.currentUser = currentUser
      App.currentUser

  App.reqres.setHandler "user:entity", (id) ->
    API.getUser(id)

  App.reqres.setHandler "new:user", ->
    API.newUser()

  App.reqres.setHandler "current:user", (fetch)->
    API.currentUser(fetch)

  App.reqres.setHandler "set:current:user", (user) ->
    API.setCurrentUser(user)

  App.vent.on "reset:current:user", ->
    API.resetCurrentUser()

