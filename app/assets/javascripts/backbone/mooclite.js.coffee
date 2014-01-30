@Mooclite = do (Backbone,Marionette) ->

  App = new Marionette.Application

  App.rootRoute = "users"

  App.on "initialize:before", (options) ->
    @currentUser = App.request "set:current:user", options.currentUser

  App.reqres.setHandler "get:current:user", ->
    App.currentUser

  App.addRegions 
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("FooterApp").start()
    App.module("HeaderApp").start()

  App.on "initialize:after",(options) ->
    if Backbone.history
      Backbone.history.start()
      @navigate(@rootRoute) if @getCurrentRoute() is "" 

  App.navigate = (route) ->
    Backbone.history.navigate route

  App.getCurrentRoute = ->
    Backbone.history.fragment


  App