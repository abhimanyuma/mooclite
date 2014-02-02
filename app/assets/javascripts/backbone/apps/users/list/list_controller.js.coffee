@Mooclite.module "UsersApp.List", (List, App,Backbone, Marionette,$,_) ->

  List.Controller = 

    listUsers: ->
      users = App.request "user:entities"
      @layout = @getLayoutView()

      App.mainRegion.show @layout

    getLayoutView: ->
      new List.Layout
