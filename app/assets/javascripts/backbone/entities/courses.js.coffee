@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.Course extends Entities.Model
    urlRoot: ->
      if @user_id
        user_id = @user_id
      else if @get("user_id")
        user_id = @get("user_id")
      else if @collection && @collection.user_id
        user_id = @get("user_id")

      Routes.user_courses_path(user_id)

    jsUrl: ->
      "/courses/#{@id}"

    setUpLectures:(callback) ->
      App.request "create:lectures", @get("lectures"), @, callback

  class Entities.CoursesCollection extends Entities.Collection
    model:Entities.Course
    url: ->
      Routes.user_courses_path(@user_id)

  API=
    getCoursesCollection: (user_id)  ->
      courses= new Entities.CoursesCollection
      courses.user_id = user_id
      courses.fetch()
      courses

    getCourse: (user_id,id) ->
      course = new Entities.Course
        id: id
      course.user_id = user_id
      course.fetch()
      course

    newCourse:(user_id) ->
      course = new Entities.Course
      course.user_id = user_id
      course


  App.reqres.setHandler "course:entity", (user_id,id) ->
    API.getCourse(user_id,id)

  App.reqres.setHandler "course:entities", (user_id) ->
    API.getCoursesCollection(user_id)

  App.reqres.setHandler "new:course", (user_id) ->
    API.newCourse(user_id)
