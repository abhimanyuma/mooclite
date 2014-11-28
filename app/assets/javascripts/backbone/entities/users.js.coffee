@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.User extends Entities.Model
    urlRoot: -> Routes.users_path()

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
      unless App.currentUser
        App.currentUser = new Entities.CurrentUser
        App.currentUser.fetch()

      App.currentUser.fetch() if fetch

      App.currentUser

  App.reqres.setHandler "user:entity", (id) ->
    API.getUser(id)

  App.reqres.setHandler "new:user", ->
    API.newUser()

  App.reqres.setHandler "current:user", (fetch)->
    API.currentUser(fetch)

