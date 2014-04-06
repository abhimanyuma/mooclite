@Mooclite.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Lecture extends Entities.Model
    urlRoot:  -> '/lectures'

  class Entities.LecturesCollection extends Entities.Collection
    model: Entities.Lecture
    url: -> '/lectures'

  API =
    getLectures: ->
      lectures = new Entities.LecturesCollection [
        {lecture_no: 1, title: "Introduction"}
        {lecture_no: 2, title: "So far so good"}
        {lecture_no: 3, title: "Total Chaos"}
        {lecture_no: 4, title: "Back from future"}
        {lecture_no: 5, title: "There is no going back"}
      ]
      #lectures.fetch
      #  reset: true
      lectures

    getLecture: (id) ->
      lectures = new Entities.Lecture
        id: id
      lectures.fetch()
      lectures

    newLecture: ->
      new Entities.Lecture

  App.reqres.setHandler "lecture:entities", ->
    API.getLectures()

  #App.reqres.setHandler "lectures:entity", (id) ->
    #API.getLecture id

  #App.reqres.setHandler "new:lectures:entity", ->
    #API.newLecture()