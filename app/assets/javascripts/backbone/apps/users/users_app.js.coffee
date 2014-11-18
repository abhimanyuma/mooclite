@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "users": "list"
      "users/new":"new"
      "users/:id": "show"
      "users/:id/edit": "edit"
      "signup" : "new"
      "login" : "login"

    before: ->
      App.vent.trigger "nav:choose", "Users"
    
  API =
    new: ->
      new UsersApp.New.Controller

    list: ->
      new UsersApp.List.Controller

    show: ->
      new UsersApp.Show.Controller

    edit: ->
      new UsersApp.Edit.Controller

    login: ->
      App.request "get:loginpatch"

      
  App.addInitializer ->
    new UsersApp.Router
      controller: API

  App.vent.on "new:user:clicked", ->
    App.navigate Routes.new_user_path()
    API.new()

  App.vent.on "user:created", (user) ->
    toastr.success("Let us build the future of MOOCs together","Welcome #{user.get('name')}")
    App.navigate Routes.root_path()

  App.vent.on "user:create:cancelled", ->
    toastr.error("","User Creation Failed")
    App.navigate Routes.root_path()
