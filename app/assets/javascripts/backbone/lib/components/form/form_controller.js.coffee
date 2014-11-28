@Mooclite.module "Components.Form" , (Form, App, Backbone, Marionette, $, _) ->

  class Form.Controller extends Marionette.Controller

    initialize: (options={}) ->
      @contentView = options.view

      @formLayout = @getFormLayout options.config

      @listenTo @formLayout, "show", @formContentRegion

      @listenTo @formLayout, "destroy", @destroy

      @listenTo @formLayout, "form:submit", @formSubmit

      @listenTo @formLayout, "form:cancel", @formCancel

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

    getFormLayout: (options={}) ->
      config = @getDefaultConfig _.result(@contentView, "form")
      _.extend config, options

      buttons = @getButtons config.buttons
      
      new Form.FormWrapper
        config: config
        model: @contentView.model
        buttons: buttons

    getDefaultConfig: (config = {}) ->
      _.defaults config,
        footer: true
        focusFirstInput: true
        errors: true
        syncing: true

    getButtons: (buttons= {}) ->
      App.request("form:button:entities",buttons,@contentView.model) unless buttons is false

  App.reqres.setHandler "form:wrapper", (contentView,options={}) ->
    throw new Error "No model found inside" unless contentView.model
    formController = new Form.Controller
      view:contentView
      config:options

    formController.formLayout