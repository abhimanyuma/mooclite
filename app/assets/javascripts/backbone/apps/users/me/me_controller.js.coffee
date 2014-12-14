@Mooclite.module "UsersApp.Me", (Me, App, Backbone, Marionette, $, _) ->

  class Me.Controller extends App.Controllers.Application

    initialize: ->

      App.redirectIfNotLoggedIn()

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

      @listenTo apiKeyView, "create:api:key:button:clicked", (element) =>
        if element.collection

          options = {}
          that = @

          options.successcb = ->
            element.view.stopLoadingAdd()

          options.errorcb = ->
            element.view.stopLoadingAdd()

          element.view.showLoadingAdd()
          element.collection.createNewApiKey(options)

      @listenTo apiKeyView, "childview:delete:button:clicked", (view) =>
        view.showConfirmationButtons()

      @listenTo apiKeyView, "childview:delete:cancellation:clicked", (view) =>
        view.hideConfirmationButtons()

      @listenTo apiKeyView, "childview:delete:confirmation:clicked", (view) =>
        if view.model
          options = {}

          options.successcb = ->
            view.stopLoadingDelete()

          options.errorcb = ->
            view.stopLoadingDelete()

          view.showLoadingDelete()
          view.model.doDelete(options)

      @layout.apiKeyRegion.show apiKeyView

    getLayoutView: ->
      new Me.Layout

    getMeView: (profile) ->
      new Me.MeView
        model: profile

    getApiKeyView: (apiCollection) ->
      new Me.ApiKeys
        collection: apiCollection

