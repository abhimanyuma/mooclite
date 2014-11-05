@Mooclite.module "StaticApp", (StaticApp, App, Backbone, Marionette, $, _) ->

  class StaticApp.Router extends Marionette.AppRouter
    appRoutes:
      "": "home"

  API =
   home: ->
      new StaticApp.Home.Controller


  App.addInitializer ->
    new StaticApp.Router
      controller: API
