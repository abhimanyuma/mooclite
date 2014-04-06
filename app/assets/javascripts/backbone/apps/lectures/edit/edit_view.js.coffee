@Mooclite.module "LecturesApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends Marionette.Layout
    template: "lectures/edit/edit_layout"

    regions:
      fooRegion: "#foo-region"