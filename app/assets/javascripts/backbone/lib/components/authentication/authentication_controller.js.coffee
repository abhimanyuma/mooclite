@Mooclite.module "Components.Authentication" , (Authentication, App, Backbone, Marionette, $, _) ->

  class Authentication.Controller extends App.Controllers.Application

    initialize: (options={}) ->

      {view} = options

      authModel = App.request "new:authmodel"

      @listenTo authModel, "created", ->
        @authenticateProcess authModel

      if @view
        baseView = @view
      else
        baseView = @getAuthView authModel

      formView = App.request "form:wrapper", baseView

      @listenTo baseView, "form:cancel", ->
        App.vent.trigger "user:login:cancelled"

      @show formView

    getAuthView: (authModel) ->
      new Authentication.View
        model: authModel

    authenticateProcess: (authModel) ->
      console.log authModel

  App.reqres.setHandler "get:loginpatch", ->
    new Authentication.Controller