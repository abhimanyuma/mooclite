@Mooclite.module "Components.Form" , (Form, App, Backbone, Marionette, $, _) ->

  class Form.FormWrapper extends App.Views.Layout

    template: "form/form"

    tagName: "form"
    className: "ui form segment"

    attributes: ->
      "data-type" : @getFormDataType()

    regions:
      formContentRegion: "#form-content-region"
    ui:
      buttonContainer: "#footer-div"

    triggers:
      "submit" : "form:submit"

    initialize: ->
      @setInstancePropertiesFor "config","buttons"

    serializeData: ->
      footer:@config.footer
      buttons: @buttons?.toJSON() ? false

    onShow: ->
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    buttonPlacement: ->
      @ui.buttonContainer.addClass @buttons.placement

    focusFirstInput: ->
      $(":input:visible:enabled:first").focus()

    getFormDataType: ->
      if @model.isNew() then "new" else "edit "