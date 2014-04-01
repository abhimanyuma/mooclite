@Mooclite = do (Backbone,Marionette) ->

  App = new Marionette.Application

  App.rootRoute = "courses"

  App.on "initialize:before", (options) ->
    App.environment=options.environment

  App.addRegions 
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("FooterApp").start()
    App.module("HeaderApp").start()

  App.reqres.setHandler "default:region", ->
    App.mainRegion


  App.on "initialize:after",(options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute() 

  App