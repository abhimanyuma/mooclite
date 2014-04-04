@Mooclite.module "UsersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends Marionette.Layout
    template: "users/edit/edit_layout"

    regions:
      fooRegion: "#foo-region"