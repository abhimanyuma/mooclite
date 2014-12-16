@Mooclite.module "LecturesApp", (LecturesApp, App, Backbone, Marionette, $, _) ->

  class LecturesApp.Router extends Marionette.AppRouter
    appRoutes:
      "courses/:id/lectures/new" : "newLecture"
      "courses/:id/lectures/:id": "show"
      "courses/:id/lectures/:id/edit": "edit"
      "courses/:id/lectures/:id/update_files": "updateFiles"

    before: ->
      App.vent.trigger "nav:choose", "Courses"

  API =
    show: (course_id,lecture_id) ->
      new LecturesApp.Show.Controller
        course_id:course_id
        lecture_id:lecture_id

    edit: (course_id,lecture_id,region) ->
      new LecturesApp.Edit.Controller
        course_id:course_id
        lecture_id:lecture_id

    newLecture: (course_id,course) ->
      new LecturesApp.New.Controller
        course_id: course_id
        course: course

    list: (course,lectures,region) ->
      new LecturesApp.List.Controller
        course:course
        lectures:lectures
        region:region

    updateFiles: (course,lecture,preloaded) ->
      if preloaded
        new LecturesApp.UpdateFiles.Controller
          course:course
          lecture:lecture
      else
        new LecturesApp.UpdateFiles.Controller
          course_id:course
          lecture_id:lecture




  App.vent.on "lecture:clicked", (course_id,lecture_id) ->
    # Not using Routes because it doesn't support nesting
    App.navigate "courses/#{course_id}/lectures/#{lecture_id}"
    API.show(course_id,lecture_id)

  App.vent.on "new:lecture:clicked", (user,course) ->
    App.navigate "courses/#{course.id}/lectures/new"
    API.newLecture course.id,course

  App.vent.on "lecture:create:cancelled", (course) ->
    App.navigate "courses/#{course.id}"
    App.vent.trigger "course:clicked", course

  App.vent.on "lecture:created", (course,lecture) ->
    toastr.success("#{lecture.get('title')} has been created")
    App.navigate "courses/#{course.id}/lecture/#{lecture.id}"
    API.show(course.id,lecture.id)

  App.vent.on "lecture:edit:clicked", (course,lecture) ->
    App.navigate "courses/#{course.id}/lectures/#{lecture.id}/edit"
    API.edit course.id, lecture.id

  App.vent.on "lecture:update:files:clicked", (course,lecture) ->
    App.navigate "courses/#{course.id}/lectures/#{lecture.id}/update_files"
    API.updateFiles course, lecture, true

  App.vent.on "lecture:updated", (course, lecture) ->
    toastr.success("Details of #{lecture.get('title')} was updated successfully","Lecture Updated")
    App.navigate "courses/#{course.id}/lectures/#{lecture.id}"
    API.show(course.id,lecture.id)

  App.vent.on "lecture:cancelled", (course, lecture) ->
    toastr.info("Editing of #{lecture.get('title')} was cancelled", "Lecture not edited")
    App.navigate "courses/#{course.id}/lectures/#{lecture.id}"
    API.show(course.id,lecture.id)

  App.vent.on "lecture:update:files:cancelled", (course_id,lecture) ->
    toastr.info("Updating files  of #{lecture.get('title')} was cancelled", "Lecture files not updated")
    App.navigate "courses/#{course_id}/lectures/#{lecture.id}"
    API.show(course_id,lecture.id)

  App.vent.on "lecture:update:files:success", (course_id, lecture) ->
    toastr.info("Updating files  of #{lecture.get('title')} succeeded", "Lecture files updated")
    App.navigate "courses/#{course_id}/lectures/#{lecture.id}"
    API.show(course_id,lecture.id)

  App.commands.setHandler "list:lectures", (course,lectures,region) ->
    API.list course,lectures,region

  App.addInitializer ->
    new LecturesApp.Router
      controller: API