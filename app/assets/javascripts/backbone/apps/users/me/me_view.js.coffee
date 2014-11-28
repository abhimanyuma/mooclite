@Mooclite.module "UsersApp.Me", (Me, App, Backbone, Marionette, $, _) ->

  class Me.Layout extends App.Views.Layout
    template: "users/me/me_layout"

    regions:
      profileRegion: "#profile-region"

  class Me.MeView extends App.Views.ItemView
    template: "users/me/me"