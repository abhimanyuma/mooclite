@Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->

      { navs } = options

      headerView = @getView navs
      @show headerView
      
    getView: (links) ->
      new List.Headers
        collection: links