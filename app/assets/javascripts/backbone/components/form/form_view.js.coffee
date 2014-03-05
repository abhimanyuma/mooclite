@Mooclite.module "Components.Form" , (Form, App, Backbone, Marionette, $, _) ->

  class Form.FormWrapper extends App.Views.Layout

    template: "form/form"

    tagName: "form"
    className: "ui form segment"

    regions:
      formContentRegion: "#form-content-region"

    serializeData: ->
      footer: @options.config.footer