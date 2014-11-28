@Mooclite.module "UsersApp.Me", (Me, App, Backbone, Marionette, $, _) ->

  class Me.Controller extends App.Controllers.Application

    initialize: ->
      console.log "here"
      @layout = @getLayoutView()
      profile = App.request "current:user"

      @listenTo @layout, "show", =>
        @showMeView(profile)

      @show @layout,
        loading:
          entities: profile

    showMeView:(profile) ->
      meView = @getMeView (profile)
      @layout.profileRegion.show meView

    getLayoutView: ->
      new Me.Layout

    getMeView: (profile) ->
      console.log profile
      new Me.MeView
        model: profile
