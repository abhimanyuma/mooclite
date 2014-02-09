@Mooclite.module "HeaderApp", (HeaderApp,App,Backbone,Marionette,$,_) ->

  @startWithParent = false

  API =
    list:->
      HeaderApp.List.Controller.list()
  
  HeaderApp.on "start", ->
    API.list() 