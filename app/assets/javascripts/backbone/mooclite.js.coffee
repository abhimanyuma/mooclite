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


  App.commands.setHandler "register:instance", (instance,id) ->
    App.register instance,id if App.environment is "development"

  App.commands.setHandler "deregister:instance", (instance,id) ->
    App.deregister instance,id if App.environment is "development"

  App.on "initialize:after",(options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute() 

  App