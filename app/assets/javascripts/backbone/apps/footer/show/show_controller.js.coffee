@Mooclite.module "FooterApp.Show", (Show,App,Backbone,Marionette,$,_) ->

  class Show.Controller extends App.Controllers.Base

    initialize: -> 
      footerView = @getView()
      @show footerView

    getView: ->
      new Show.Footer