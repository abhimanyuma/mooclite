@Mooclite.module "UsersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: ->
      @layout = @getLayoutView()

      @listenTo @layout, "show", =>

      @show @layout

    getLayoutView: ->
      new New.Layout