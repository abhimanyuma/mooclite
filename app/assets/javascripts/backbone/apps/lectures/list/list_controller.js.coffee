@Mooclite.module "LecturesApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  class List.Controller extends App.Controllers.Application

    initialize:(options) ->

      {lectures,course,region} = options
      listView = @getLecturesView lectures
      region.show listView


    getLecturesView: (lectures) ->
      new List.Lectures
        collection: lectures