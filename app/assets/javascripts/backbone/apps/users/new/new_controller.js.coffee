@Mooclite.module "UsersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: ->
      user = App.request "new:user"

      @listenTo user, "created", ->
        App.vent.trigger "user:created", course


      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @showNewUserView user
        @showTitleView()

      @show @layout,
        loading: true

    getLayoutView: ->
      new New.Layout

    showNewUserView: (user) ->
      baseView = getNewUserView user

      formView = App.request "form:wrapper", baseView

      @show formView,
        region: @layout.formRegion


    getNewUserView: ->
      new New.User
        model: user

    showTitleView: ->
      titleView = getTitleView()
      @layout.titleRegion.show titleView

    getTitleView: ->
      new New.Title



