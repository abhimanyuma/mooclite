@Mooclite.module "UsersApp.Me", (Me, App, Backbone, Marionette, $, _) ->

  class Me.Controller extends App.Controllers.Application

    initialize: ->
      @layout = @getLayoutView()
      profile = App.request "current:user"

      @listenTo @layout, "show", =>
        @showMeView(profile)
        @showApiKeyView(profile.api_keys)

      @show @layout,
        loading:
          entities: profile

    showMeView:(profile) ->
      meView = @getMeView(profile)

      @layout.profileRegion.show meView

    showApiKeyView: (apiCollection) ->
      apiKeyView = @getApiKeyView(apiCollection)

      @layout.apiKeyRegion.show apiKeyView

    getLayoutView: ->
      new Me.Layout

    getMeView: (profile) ->
      new Me.MeView
        model: profile

    getApiKeyView: (apiCollection) ->
      new Me.ApiKeys
        collection: apiCollection

