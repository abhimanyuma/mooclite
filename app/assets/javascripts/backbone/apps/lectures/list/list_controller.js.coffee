@Mooclite.module "LecturesApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  class List.Controller extends App.Controllers.Application

    initialize:(options) ->

      {lectures,course} = options

      listView = @getLecturesView lectures

      @listenTo listView, "new:lecture:button:clicked", (element) ->
        App.vent.trigger "new:lecture:clicked", App.currentUser, course

      @show listView


    getLecturesView: (lectures) ->
      new List.Lectures
        collection: lectures