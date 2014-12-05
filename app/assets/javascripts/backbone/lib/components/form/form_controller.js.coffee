@Mooclite.module "Components.Form" , (Form, App, Backbone, Marionette, $, _) ->

  class Form.Controller extends Marionette.Controller

    initialize: (options={}) ->
      @contentView = options.view
      @type = options.config.type if options.config.type
      @type ?= "default"


      config = @getDefaultConfig _.result(@contentView, "form")
      _.extend config, options.config

      @formLayout = @getFormLayout config

      @listenTo @formLayout, "show", @formContentRegion

      @listenTo @formLayout, "destroy", @destroy

      for trigger in config.triggers
          @listenTo @formLayout, trigger.string, trigger.function

    formCancel: ->
      @contentView.triggerMethod "form:cancel"

    formSubmit: ->
      data = Backbone.Syphon.serialize @formLayout
      if @contentView.triggerMethod("form:submit", data) isnt false
        model = @contentView.model
        collection = @contentView.collection
        @processFormSubmit data, model, collection
      else
        @contentView.triggerMethod "form:submit", data

    processFormSubmit: (data,model,collection) ->
      model.save data,
        collection: collection

    formContentRegion: ->
      @formLayout.formContentRegion.show @contentView

    getFormLayout: (config) ->
      if config.type == "default"
        buttons = @getButtons config.buttons
      else if config.type == "login"
        buttons = @getButtons config.buttons,"login:button:entities"

      new Form.FormWrapper
        config: config
        model: @contentView.model
        buttons: buttons

    getDefaultConfig: (config = {}) ->
      that = @
      _.defaults config,
        footer: true
        focusFirstInput: true
        errors: true
        syncing: true
        type: "default"
        triggers: [
          {action: "submit", string: "form:submit", function: that.formSubmit},
          {action: "click [data-form-button='cancel']", string: "form:cancel",function: that.formCancel}
        ]

    getButtons: (buttons= {},reqString = "form:button:entities") ->
      App.request(reqString,buttons,@contentView.model) unless buttons is false

  App.reqres.setHandler "form:wrapper", (contentView,options={}) ->
    throw new Error "No model found inside" unless contentView.model
    formController = new Form.Controller
      view:contentView
      config:options

    formController.formLayout