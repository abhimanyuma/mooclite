@Mooclite.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  
  class Controllers.Base extends Marionette.Controller

    constructor: (options={}) ->
      @region = options.region or App.request "default:region"
      super options

    close: ->
      super
  
    show: (view,options={}) ->
      _.defaults options,
        loading: false
        region: @region

      @_setMainView view
       
      @_manageView view, options

    _setMainView: (view) ->
      return if @_mainView
      @_mainView = view
      @listenTo view, "close", @close

    _manageView: (view,options) ->
      if options.loading
        console.log "only once"
        console.info view
        App.execute "show:loading", view, options
      else
        console.info view
        options.region.show view
