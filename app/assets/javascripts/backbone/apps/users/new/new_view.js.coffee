@Mooclite.module "UsersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Layout extends App.Views.Layout
    template: "users/new/new_layout"

    regions:
      titleRegion: "#title-region"
      formRegion:"#form-region"

  class New.User extends App.Views.ItemView
    template: "users/new/new_user"

  class New.Title extends App.Views.ItemView
    template: "users/new/new_title"
