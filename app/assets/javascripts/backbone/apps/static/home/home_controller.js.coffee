@Mooclite.module "StaticApp.Home", (Home, App, Backbone, Marionette, $, _) ->

  class Home.Controller extends App.Controllers.Application

    initialize: ->
      @layout = @getView()

      @listenTo @layout, "new:user:button:clicked" , (model,args) ->
        App.vent.trigger "new:user:clicked" , args.model

      @listenTo @layout, "login:user:button:clicked", (model,args) ->
        App.vent.trigger "login:user" , args.model

      @show @layout

    getView: ->
      new Home.Layout