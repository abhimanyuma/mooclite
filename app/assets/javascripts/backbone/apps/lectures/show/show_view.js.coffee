@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "lectures/show/show_layout"

    regions:
      fooRegion: "#foo-region"