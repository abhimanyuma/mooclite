@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
     
      {course,lecture} = options

      @layout = @getLayoutView course,lecture

      console.log course,lecture

      @listenTo @layout, "show", =>

      @show @layout

    getLayoutView:(course,lecture) ->
      new Show.Layout
        lecture:lecture
        course:course