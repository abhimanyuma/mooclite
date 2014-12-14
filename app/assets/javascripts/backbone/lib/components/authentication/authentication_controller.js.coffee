@Mooclite.module "Components.Authentication" , (Authentication, App, Backbone, Marionette, $, _) ->

  class Authentication.Controller extends App.Controllers.Application

    initialize: (options={}) ->
      {view,@profile,@redirectTo} = options


      @profile ?= App.request "current:user"

      if @profile.get('id')
        @redirectIfLoggedIn()
      else
        @listenTo @profile, "sync", ->
          @redirectIfLoggedIn()
        @listenTo @profile, "error", ->
          @redirectIfLoggedIn()

      authModel = new Mooclite.Entities.Model

      if @view
        baseView = @view
      else
        baseView = @getAuthView authModel

      @formView = App.request "form:wrapper", baseView,
        type:"login"
        triggers: [
          {action: "click .login-button",string: "login:button:clicked",function: @onLogin}
        ]

      if @profile
        @show @formView,
          entities: @profile
      else
        @show @formView

    onLogin:  () =>
      @formView.removeErrors()

      onLoginSuccess = (data,status,jqXHR) =>
        @formView.syncStop()
        currentUser = App.request "set:current:user", data
        App.vent.trigger "user:login:success"


      onLoginError = (jqXHR, status, error) =>
        @formView.syncStop()
        errors =  jqXHR.responseJSON.errors
        @formView.addErrors(errors)


      data = Backbone.Syphon.serialize @formView
      data["session"] = Backbone.Syphon.serialize @formView

      $.ajax
        url:  Routes.sessions_path()
        type: "POST"
        data: data
        dataType: "json"
        success: onLoginSuccess
        error: onLoginError

      @formView.syncStart()


    getAuthView: (authModel) ->
      new Authentication.View
        model: authModel

    authenticateProcess: (authModel) ->
      App.vent.trigger "user:login:success"

    redirectIfLoggedIn: () ->
      if @profile.get('id')
        App.vent.trigger "user:login:success", @redirectTo


  App.reqres.setHandler "get:loginpatch", (options) ->
    new Authentication.Controller(options)