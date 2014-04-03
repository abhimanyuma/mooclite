@Mooclite.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Nav extends Entities.Model

    choose: ->
      @set chosen: true

    unchoose: ->
      @set chosen: false

    chooseByCollection: ->
      @collection.choose @

  class Entities.NavsCollection extends Entities.Collection
    model: Entities.Nav

    choose: (model) ->
      _(@where chosen:true).invoke("unchoose")
      model.choose()

    chooseByName: (nav) ->
      @choose @findWhere(name: nav)

  API =
    getNavs: ->
      navs = new Entities.NavsCollection [
        { name: "Courses" ,    url: "#courses",    icon:"book" },
        { name: "Users" ,      url:"#users",       icon:"users" },
        { name: "Institutes" , url: "#institutes", icon:"building" }
      ]
      navs


  App.reqres.setHandler "nav:entities", ->
    API.getNavs()