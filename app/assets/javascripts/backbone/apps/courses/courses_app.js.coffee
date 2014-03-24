@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses/:id/edit" : "edit"
      "courses" : "list"

  API = 
    list: ->
      new CoursesApp.List.Controller
    newCourse: ->
      CoursesApp.New.Controller.newCourse()
    edit: (id) ->
      CoursesApp.Edit.Controller.edit(id)

  App.reqres.setHandler "new:course:view", ->
    API.newCourse()

  App.vent.on "course:clicked", (course) ->
    App.navigate Routes.edit_course_path(course.id)
    API.edit course.id

  App.vent.on "course:created", (course) ->
    toastr.success("New course on #{course.get('name')} was created","Course Created")
    App.vent.trigger "course:clicked", course

  App.vent.on "course:cancelled", (course) -> 
    toastr.info("Details of  #{course.get('name')} was not updated","Edit Cancelled")
    App.navigate Routes.courses_path()
    API.list()
    

  App.vent.on "course:updated", (course) ->
    toastr.success("Details of #{course.get('name')} was updated successfully","Course Updated")
    App.navigate Routes.courses_path()
    API.list()
  
  App.vent.on "course:delete", (course) ->
    if confirm "Do you really want to delete #{course.get('name')}?" then course.destroy() else false
    toastr.success("#{course.get('name')} was deleted successfully","Course Deleted")
    App.navigate Routes.courses_path()
    API.list()

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API
