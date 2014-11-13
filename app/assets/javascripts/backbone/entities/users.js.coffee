@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.User extends Entities.Model
    urlRoot: -> Routes.users_path()

  API=
    getCourse: (id) ->
      user = new Entities.User
        id: id
      user.fetch()
      user

    newUser: ->
      new Entities.User


  App.reqres.setHandler "user:entity", (id) ->
    API.getUser(id)

  App.reqres.setHandler "new:user", ->
    API.newUser()
