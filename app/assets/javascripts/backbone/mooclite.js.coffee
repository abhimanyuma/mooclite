@Mooclite = do (Backbone,Marionette) ->

  App = new Marionette.Application

  App.rootRoute = ""

  App.on "before:start", (options) ->
    App.environment = options.environment
    App.navs = App.request "nav:entities"

  App.addRegions
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("FooterApp").start()
    App.module("HeaderApp").start(App.navs)


  App.vent.on "nav:choose", (nav) ->
    App.navs.chooseByName nav

  App.reqres.setHandler "default:region", ->
    App.mainRegion


  App.on "start",(options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App