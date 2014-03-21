@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  class Edit.Layout extends App.Views.Layout
    template: "courses/edit/edit_layout"

    regions:
      titleRegion: "#title-region"
      formRegion:"#form-region"

  class Edit.Course extends App.Views.ItemView

    template: "courses/edit/edit_course"

    triggers:
      "keyup #bio": "updateBioLength"

    updateBioLength: ->
      console.log "Here"
      gon.bio_length=@$('#bio').val().length
      @$("#bio-length").text="#{gon.bio_max-gon.bio_length}"

  class Edit.Title extends App.Views.ItemView
    template: "courses/edit/title"

    modelEvents:
      "updated":"render"

    