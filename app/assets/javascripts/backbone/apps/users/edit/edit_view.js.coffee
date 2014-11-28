@Mooclite.module "UsersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends Marionette.LayoutView
    template: "users/edit/edit_layout"

    regions:
      fooRegion: "#foo-region"