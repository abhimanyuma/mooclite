@Mooclite.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Lecture extends Entities.Model

    initialize: (options) ->
      {course_id,lecture_no} = options

      if @collection and @collection.course_id
        @course_id = @collection.course_id
      else
        @course_id = course_id
        @set("course_id",course_id)

    urlRoot:  ->
      Routes.user_course_lectures_path(App.currentUser.id.$oid,@course_id)


  class Entities.LecturesCollection extends Entities.Collection
    model: Entities.Lecture

    initialize: (options) ->

      {course_id} = options
      @course_id = course_id

    url: ->  Routes.user_course_lectures_path(App.currentUser.id.$oid,@course_id)

  API =
    getLectures: (course_id) ->
      lectures = new Entities.LecturesCollection
        course_id:course_id
      lectures.fetch
        reset: true
      lectures

    getLecture: (course_id,id) ->
      lecture = new Entities.Lecture
        course_id: course_id
        lecture_no: id
      lecture.fetch()
      lecture


    newLecture:(course_id) ->
      lecture = new Entities.Lecture
        course_id: course_id
      lecture

    createLectures: (data,course,cb) ->
      course.lectures = new Entities.LecturesCollection(data)
      course.lectures.course_id = course.id
      for model in course.lectures.models
        model.course_id = course.id
        model.collection = course.lectures

      cb(course.lectures)

  App.reqres.setHandler "lecture:entities", (course_id) ->
    API.getLectures(course_id)

  App.reqres.setHandler "lecture:entity", (course_id,id) ->
    API.getLecture course_id, id

  App.reqres.setHandler "new:lecture:entity",(course_id) ->
    API.newLecture(course_id)

  App.reqres.setHandler "create:lectures", (data,course,cb) ->
    API.createLectures(data,course,cb)