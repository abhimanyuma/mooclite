@Mooclite.module "LecturesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Layout extends App.Views.Layout
    template: "lectures/new/new_layout"

    regions:
      titleRegion: "#title-region"
      formRegion:  "#form-region"
      modalRegion: "#modal-region"

  class New.Form extends App.Views.ItemView

    template: "lectures/shared/edit_lecture"

    triggers:
      "keyup #overview": "overview:updated"

  class New.Title extends App.Views.ItemView
    template: "lectures/new/title"

    modelEvents:
      "updated":"render"