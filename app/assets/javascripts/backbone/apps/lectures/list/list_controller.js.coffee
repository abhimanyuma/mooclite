@Mooclite.module "LecturesApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  class List.Controller extends App.Controllers.Application

    initialize:(options) ->

      {lectures,course} = options

      listView = @getLecturesView lectures

      @listenTo listView, "new:lecture:button:clicked", (element) ->
        App.vent.trigger "new:lecture:clicked", App.currentUser, course

      @listenTo listView, "childview:lecture:clicked", (element) ->
        App.vent.trigger "lecture:clicked", course.id, element.model.id

      @listenTo listView, "childview:delete:lecture:button:clicked", (view) =>
        view.showConfirmationButtons()

      @listenTo listView, "childview:delete:lecture:cancellation:clicked", (view) =>
        view.hideConfirmationButtons()

      @listenTo listView, "childview:delete:lecture:confirmation:clicked", (view) =>
        if view.model
          options = {}

          options.successcb = ->
            view.stopLoadingDelete()

          options.errorcb = ->
            view.stopLoadingDelete()

          view.showLoadingDelete()
          view.model.doDelete(options)


      @show listView


    getLecturesView: (lectures) ->
      new List.Lectures
        collection: lectures