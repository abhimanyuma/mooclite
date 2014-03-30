@Mooclite.module "Components.Loading" , (Loading, App, Backbone, Marionette, $, _ ) ->
  
  class Loading.LoadingController extends App.Controllers.Base

    initialize: (options) ->
      {view, config}=options

      _.defaults config,
        entities: @getEntities view

      loadingView = @getLoadingView()

      @show loadingView

      @showRealView view,config

    showRealView: (realView,config) ->
      App.execute "when:fetched", config.entities, =>
        console.log "Something has come"

        @show realView

    getEntities: (view) ->
      _.chain(view).pick("model","collection").toArray().compact().value()

    getLoadingView: ->
      new Loading.LoadingView


  App.commands.setHandler "show:loading", (view,options) ->
    new Loading.LoadingController
      view: view
      region: options.region
      config: options.loading
