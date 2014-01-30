@Mooclite.module "Entities", (Entities,App, Backbone,Marionette, $, _) ->

  class Entities.User extends Backbone.Model

  class Entities.UsersCollection extends Backbone.Collection
    model: Entities.User

  API = 
    setCurrentUser: (currentUser) ->
      new Entities.User currentUser

  App.reqres.setHandler "set:current:user", (currentUser) ->
    API.setCurrentUser currentUser