@Mooclite.module "UsersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Layout extends Marionette.Layout
    template: "users/new/new_layout"

    regions:
      fooRegion: "#foo-region"