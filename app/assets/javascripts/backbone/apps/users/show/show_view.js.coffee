@Mooclite.module "UsersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends Marionette.Layout
    template: "users/show/show_layout"

    regions:
      fooRegion: "#foo-region"