@Mooclite.module "Entities", (Entities, App, Backbone, Marionette,$, _) ->

  class Entities.Session extends Entities.Model
    urlRoot: "api/sessions"

  API =
    newSession: ->
      new Entities.Session

  App.reqres.setHandler "new:session", ->
    API.newSession()
