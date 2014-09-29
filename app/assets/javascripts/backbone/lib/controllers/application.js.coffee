@Mooclite.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.Application extends Marionette.Controller

    constructor: (options={}) ->
      @region = options.region or App.request "default:region"
      super options
      @_instance_id = _.uniqueId("constructor")
      App.execute "register:instance", @,@_instance_id

    close: ->
      super
      App.execute "deregister:instance",@,@_instance_id

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
        App.execute "show:loading", view, options
      else
        options.region.show view
