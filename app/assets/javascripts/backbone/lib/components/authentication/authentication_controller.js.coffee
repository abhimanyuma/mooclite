@Mooclite.module "Components.Authentication" , (Authentication, App, Backbone, Marionette, $, _) ->

  class Authentication.Controller extends App.Controllers.Application

    initialize: (options={}) ->
      {view,@profile} = options


      if @profile
        if @profile.sync_status
          @redirectIfLoggedIn()
        else
          @listenTo @profile, "sync", ->
            @redirectIfLoggedIn()
          @listenTo @profile, "error", ->
            @redirectIfLoggedIn()

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

      if @profile
        @show formView,
          entities: @profile
      else
        @show formView

    getAuthView: (authModel) ->
      new Authentication.View
        model: authModel

    authenticateProcess: (authModel) ->
      App.vent.trigger "user:login:success"

    redirectIfLoggedIn: () ->
      if @profile.get('id')
        App.vent.trigger "user:login:success"


  App.reqres.setHandler "get:loginpatch", (options) ->
    new Authentication.Controller(options)