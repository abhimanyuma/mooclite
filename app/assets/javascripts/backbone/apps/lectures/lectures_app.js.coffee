@Mooclite.module "LecturesApp", (LecturesApp, App, Backbone, Marionette, $, _) ->

  class LecturesApp.Router extends Marionette.AppRouter
    appRoutes:
      "courses/:id/lectures/:id": "show"
      "courses/:id/lectures/:id/edit": "edit"
    
  API =
    show: (course_id,lecture_id,region) ->
      return App.execute "course:show", course_id,lecture_id if not region 
      new LecturesApp.Show.Controller
        course_id:course_id
        lecture_id:lecture_id
        region:region

    edit: ->
      new LecturesApp.Edit.Controller

  

  App.vent.on "lecture:clicked", (course,lecture,region) ->
    # Not using Routes because it doesn't support nesting
    App.navigate "courses/#{course.id}/lectures/#{lecture.get("lecture_no")}"
    API.show(course.id,lecture.get("lecture_no"),region)

  App.addInitializer ->
    new LecturesApp.Router
      controller: API