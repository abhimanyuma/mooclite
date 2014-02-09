@Mooclite.module "FooterApp", (FooterApp, App, Backbone,Marionette,$, _) ->

  @startWithParent = false

  API =
    show:->
      FooterApp.Show.Controller.show()
  
  FooterApp.on "start", ->
    API.show()