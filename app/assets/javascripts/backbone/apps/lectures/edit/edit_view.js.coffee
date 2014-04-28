@Mooclite.module "LecturesApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "lectures/edit/edit_layout"

    regions:
      titleRegion: "#title-region"
      formRegion:  "#form-region"
      modalRegion: "#modal-region"

  class Edit.Form extends App.Views.ItemView

    template: "lectures/edit/edit_lecture"

    triggers:
      "keyup #overview": "overview:updated"

  class Edit.Title extends App.Views.ItemView
    template: "lectures/edit/title"

    triggers:
      "click #delete-lecture": "lecture:delete:clicked"

    modelEvents:
      "updated":"render"

  class Edit.Modal extends App.Views.ItemView
    template: "lectures/edit/modal"

    className: "ui segment"

    triggers:
      "click a": "show:modal:clicked"