@Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Controller extends App.Controllers.Application

    initialize: ->
      links = App.request "header:entities"

      headerView = @getView links
      @show headerView
      
    getView: (links) ->
      new List.Headers
        collection: links