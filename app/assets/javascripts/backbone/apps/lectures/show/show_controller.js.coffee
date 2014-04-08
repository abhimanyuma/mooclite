@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
     
      {course_id,lecture_id} = options

      course = App.request "course:entity", course_id

      lecture = App.request "lecture:entity", course_id, lecture_id

      @layout = @getLayoutView course,lecture

      @listenTo @layout, "show", =>

      @show @layout,
        loading: true

    getLayoutView:(course,lecture) ->
      new Show.Layout
        lecture:lecture
        course:course