@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses/:id/edit" : "edit"
      "courses/:id" : "show"
      "courses" : "list"

    before: ->
      App.vent.trigger "nav:choose", "Courses"

  API =
    list: ->
      new CoursesApp.List.Controller

    newCourse: (region) ->
      new CoursesApp.New.Controller
        region:region

    show: (id, course) ->
      new CoursesApp.Show.Controller
        id: id
        course: course

    showLecture: (id,lecture_id,lecture_action) ->
      new CoursesApp.Show.Controller
        id: id
        lecture_id: lecture_id
        lecture_action: lecture_action

    edit: (id, course) ->
      new CoursesApp.Edit.Controller
        id: id
        course: course

  App.commands.setHandler "new:course:view", (region) ->
    API.newCourse region

  App.commands.setHandler "course:show", (course_id,lecture_id,lecture_action) ->
    API.showLecture course_id,lecture_id,lecture_action

  App.vent.on "course:clicked", (course) ->
    App.navigate course.jsUrl()
    API.show course.id

  App.vent.on "edit:course:clicked", (course) ->
    App.navigate "#{course.jsUrl()}/edit"
    API.edit course.id,course

  App.vent.on "course:created", (course) ->
    toastr.success("New course on #{course.get('name')} was created","Course Created")
    App.vent.trigger "course:clicked", course

  App.vent.on "course:cancelled", (course) ->
    toastr.info("Details of  #{course.get('name')} was not updated","Edit Cancelled")
    App.navigate course.jsUrl()
    API.show course.id,course


  App.vent.on "course:updated", (course) ->
    toastr.success("Details of #{course.get('name')} was updated successfully","Course Updated")
    App.navigate course.jsUrl()
    API.show course.id,course

  App.vent.on "course:delete", (course) ->
    if confirm "Do you really want to delete #{course.get('name')}?" then course.destroy() else false
    toastr.success("#{course.get('name')} was deleted successfully","Course Deleted")
    App.navigate "/courses"
    API.list()

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API
