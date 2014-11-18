@Mooclite.module "Entities", (Entities, App, Backbone, Marionette,$, _) ->

  class Entities.AuthModel extends Entities.Model
    urlRoot: "api/login"

  API =
    newAuthModel: ->
      new Entities.AuthModel

  App.reqres.setHandler "new:authmodel", ->
    API.newAuthModel()
