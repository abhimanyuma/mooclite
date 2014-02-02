@Mooclite.module "Entities", (Entities,App, Backbone,Marionette, $, _) ->

  class Entities.User extends Backbone.Model

  class Entities.UsersCollection extends Backbone.Collection
    model: Entities.User
    url: -> Routes.users_path()

  API = 
    setCurrentUser: (currentUser) ->
      new Entities.User currentUser

    getUserEntities: ->
      users = new Entities.UsersCollection
      users.fetch()
      users

  App.reqres.setHandler "set:current:user", (currentUser) ->
    API.setCurrentUser currentUser

  App.reqres.setHandler "user:entities", ->
    API.getUserEntities()