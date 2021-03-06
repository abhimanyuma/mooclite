@Mooclite.module "UsersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: ->
      user = App.request "new:user"

      @listenTo user, "created", ->
        App.vent.trigger "user:created", user


      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @showNewUserView user
        @showTitleView()

      @show @layout,
        loading: true

    getLayoutView: ->
      new New.Layout

    showNewUserView: (user) ->
      baseView = @getNewUserView user

      formView = App.request "form:wrapper", baseView

      @listenTo baseView, "form:cancel", ->
        App.vent.trigger "user:create:cancelled"

      @show formView,
        region: @layout.formRegion


    getNewUserView: (user) ->
      new New.User
        model: user

    showTitleView: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    getTitleView: ->
      new New.Title



