@Mooclite.module "UsersApp.List", (List, App,Backbone, Marionette,$,_) ->

  List.Controller = 

    list: ->
      App.request "user:entities", (users) =>
        
        @layout = @getLayoutView()

        @layout.on "show", =>
          @showPanel users
          @showUsers users

        App.mainRegion.show @layout

    showPanel: (users) ->
      panelView = @getPanelView users
      @layout.panelRegion.show panelView

    showUsers: (users) ->
      usersView = @getUsersView users
      @layout.usersRegion.show usersView

    getUsers View: (users) ->
      new List.Users
        collection: users

    getPanelView: (users) ->
      new List.Panel
        collection: users

    getLayoutView: ->
      new List.Layout 
