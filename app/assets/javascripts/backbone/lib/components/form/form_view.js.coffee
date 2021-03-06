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

    modelEvents:
      "change:_errors" : "changeErrors"
      "sync:start"     : "syncStart"
      "sync:stop"      : "syncStop"

    initialize: (options = {}) ->
      @setInstancePropertiesFor "config","buttons"
      @triggers = {}
      for trigger in options.config.triggers
        @triggers[trigger.action] = trigger.string

    serializeData: ->
      footer:@config.footer
      buttons: @buttons?.toJSON() ? false

    onShow: ->
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    buttonPlacement: ->
      $(@ui.buttonContainer).addClass @buttons.placement

    focusFirstInput: ->
      $(":input:visible:enabled:first").focus()

    getFormDataType: ->
      if @model.isNew() then "new" else "edit "

    changeErrors: (model,errors,options) ->
      if @config.errors
        if _.isEmpty(errors) then @removeErrors() else @addErrors  errors

    removeErrors: ->
      @$("div.field.error").removeClass("error").find("div.ui.pointing.label").remove()
      @$el.removeClass("error")

    addErrors: (errors={}) ->
      for name,array of errors
        @addError name,array[0]
      @$el.addClass("error")

    addError: (name,error) ->
      el = @$("[name='#{name}']")
      message =  $("<div>").text(error)
      message.addClass("ui pointing red label")
      field = el.closest(".field")
      field.addClass("error")
      field.append(message)

    syncStart: ->
      @$el.addClass("loading") if @config.syncing

    syncStop: ->
      @$el.removeClass("loading") if @config.syncing