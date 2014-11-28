@Mooclite.module "UsersApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends Marionette.LayoutView
    template: "users/list/list_layout"

    regions:
      fooRegion: "#foo-region"