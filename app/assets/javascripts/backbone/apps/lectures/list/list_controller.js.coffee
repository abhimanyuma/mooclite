@Mooclite.module "LecturesApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  class List.Controller extends App.Controllers.Application

    initialize:(options) ->

      {lectures,course} = options

      listView = @getLecturesView lectures

      @listenTo listView, "new:lecture:button:clicked", (element) ->
        App.vent.trigger "new:lecture:clicked", App.currentUser, course

      @listenTo listView, "childview:lecture:clicked", (element) ->
        App.vent.trigger "lecture:clicked", course.id, element.model.id

      @show listView


    getLecturesView: (lectures) ->
      new List.Lectures
        collection: lectures