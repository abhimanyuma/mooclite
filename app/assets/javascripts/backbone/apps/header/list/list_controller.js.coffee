@Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  List.Controller =

    list: ->
      links = App.request "header:entities"

      headerView = @getView(links)
      App.headerRegion.show headerView
      
    getView: (links) ->
      new List.Headers
        collection: links