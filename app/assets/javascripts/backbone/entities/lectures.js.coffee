@Mooclite.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Lecture extends Entities.Model

    initialize: (options) ->
      {course_id,lecture_no} = options

      if @collection and @collection.course_id
        @course_id = @collection.course_id
      else
        @course_id = course_id
        @set("course_id",course_id)

    choose: ->
      @set chosen: true

    unchoose: ->
      @set chosen: false

    chooseByCollection: ->
      @collection.choose @

    urlRoot:  -> "/api/courses/#{@course_id}/lectures"
    url: ->
      if @lecture_no
        "/api/courses/#{@course_id}/lectures/#{@lecture_no}"
      else if @get('lecture_no')
        "/api/courses/#{@course_id}/lectures/#{@get('lecture_no')}"
      else
        "/api/courses/#{@course_id}/lectures"

  class Entities.LecturesCollection extends Entities.Collection
    model: Entities.Lecture

    initialize: (options) ->

      {course_id} = options
      @course_id = course_id

    url: -> "/api/courses/#{@course_id}/lectures"

    choose: (model) ->
      _(@where chosen:true).invoke("unchoose")
      model.choose()

    chooseByNo: (num) ->
      @choose @findWhere(lecture_no: num)

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

  App.reqres.setHandler "lecture:entities", (course_id) ->
    API.getLectures(course_id)

  App.reqres.setHandler "lecture:entity", (course_id,id) ->
    API.getLecture course_id, id

  App.reqres.setHandler "new:lecture:entity",(course_id) ->
    API.newLecture(course_id)