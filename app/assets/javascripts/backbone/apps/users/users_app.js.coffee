@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "users": "list"
      "users/new":"new"
      "users/:id/edit": "edit"
      "signup" : "new"
      "login" : "login"
      "me": "me"

    before: ->
      App.vent.trigger "nav:choose", "Users"

  API =
    new: ->
      new UsersApp.New.Controller

    list: ->
      new UsersApp.List.Controller

    me: ->
      new UsersApp.Me.Controller

    edit: ->
      new UsersApp.Edit.Controller

    login: (profile) ->
      if profile
        App.request "get:loginpatch",
          profile: profile
      else
        App.vent.trigger "login:user"


  App.addInitializer ->
    new UsersApp.Router
      controller: API

  App.vent.on "new:user:clicked", ->
    App.navigate Routes.new_user_path()
    API.new()

  App.vent.on "user:created", (user) ->
    toastr.success("Let us build the future of MOOCs together","Welcome #{user.get('name')}")
    App.navigate Routes.root_path()

  App.vent.on "login:user", ->
    current_user = App.request "current:user"
    App.navigate "/login"
    API.login current_user

  App.vent.on "user:create:cancelled", ->
    toastr.error("","User Creation Failed")
    App.navigate Routes.root_path()

  App.vent.on "user:login:cancelled", ->
    toastr.error("","User Login Cancelled")

  App.vent.on "user:loging:success", ->
    toastr.success("","Successful Login")
    App.navigate "/me"
    API.me

