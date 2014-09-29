@Mooclite.module "LecturesApp", (LecturesApp, App, Backbone, Marionette, $, _) ->

  class LecturesApp.Router extends Marionette.AppRouter
    appRoutes:
      "courses/:id/lectures/:id": "show"
      "courses/:id/lectures/:id/edit": "edit"

    before: ->
      App.vent.trigger "nav:choose", "Courses"

  API =
    show: (course_id,lecture_id,region) ->
      return App.execute "course:show", course_id,lecture_id if not region
      new LecturesApp.Show.Controller
        course_id:course_id
        lecture_id:lecture_id
        region:region

    edit: (course_id,lecture_id,region) ->
      return App.execute "course:show", course_id,lecture_id,true if not region
      new LecturesApp.Edit.Controller
        course_id:course_id
        lecture_id:lecture_id
        region:region



  App.vent.on "lecture:clicked", (course,lecture,region) ->
    # Not using Routes because it doesn't support nesting
    App.navigate "courses/#{course.id}/lectures/#{lecture.get("lecture_no")}"
    API.show(course.id,lecture.get("lecture_no"),region)


  App.vent.on "lecture:edit:clicked", (course,lecture,region) ->
    App.navigate "courses/#{course.id}/lectures/#{lecture.get("lecture_no")}/edit"
    API.edit course.id, lecture.get("lecture_no"), region

  App.vent.on "lecture:updated", (course, lecture, region) ->
    toastr.success("Details of #{lecture.get('title')} was updated successfully","Lecture Updated")
    App.navigate "courses/#{course.id}/lectures/#{lecture.get("lecture_no")}"
    API.show(course.id,lecture.get("lecture_no"),region)

  App.vent.on "lecture:cancelled", (course, lecture, region) ->
    toastr.info("Editing of #{lecture.get('title')} was cancelled", "Lecture not edited")
    App.navigate "courses/#{course.id}/lectures/#{lecture.get("lecture_no")}"
    API.show(course.id,lecture.get("lecture_no"),region)

  App.addInitializer ->
    new LecturesApp.Router
      controller: API