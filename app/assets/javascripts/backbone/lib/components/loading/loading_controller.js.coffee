@Mooclite.module "Components.Loading" , (Loading, App, Backbone, Marionette, $, _ ) ->
  
  class Loading.LoadingController extends App.Controllers.Base

    initialize: (options) ->
      {view, config}=options

      config = if _.isBoolean(config) then {} else config
      
      _.defaults config,
        entities: @getEntities view

      loadingView = @getLoadingView()

      @show loadingView

      @showRealView view, loadingView, config

    showRealView: (realView, loadingView, config) ->
      App.execute "when:fetched", config.entities, =>
        
        return realView.close() if @region.currentView isnt loadingView
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
