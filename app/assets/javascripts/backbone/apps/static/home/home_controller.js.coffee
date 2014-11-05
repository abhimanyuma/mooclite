@Mooclite.module "StaticApp.Home", (Home, App, Backbone, Marionette, $, _) ->

  class Home.Controller extends App.Controllers.Application

    initialize: ->
      @layout = @getView()

      @listenTo @layout, "show", =>

      @show @layout

    getView: ->
      new Home.Layout