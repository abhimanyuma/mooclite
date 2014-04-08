@Mooclite.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Lecture extends Entities.Model

    initialize: (options) -> 
      {course_id,id} = options

      if @collection and @collection.course_id
        @course_id = @collection.course_id
      else 
        @course_id = course_id

    choose: ->
      @set chosen: true

    unchoose: ->
      @set chosen: false

    chooseByCollection: ->
      @collection.choose @

    urlRoot:  -> "/api/courses/#{@course_id}/lectures"
    url: -> "/api/courses/#{@course_id}/lectures/#{@id}"

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
      console.log "Now here", num, @
      console.log @findWhere(lecture_no: num)
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
        id: id
      lecture.fetch()
      console.log "this", lecture
      lecture


    newLecture: ->
      new Entities.Lecture

  App.reqres.setHandler "lecture:entities", (course_id) ->
    API.getLectures(course_id)

  App.reqres.setHandler "lecture:entity", (course_id,id) ->
    API.getLecture course_id, id

  #App.reqres.setHandler "new:lectures:entity", ->
    #API.newLecture()