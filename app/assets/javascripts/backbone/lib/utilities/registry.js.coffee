@Mooclite.module "Utilities", (Utilities,App, Backbone, Marionette, $, _) ->

  API =

    register: (instance,id) ->
      @_registry ?={}
      @_registry[id] = instance

    deregister: (instance,id) ->
      delete @_registry[id]

    resetRegistry: ->
      oldCount=@getRegistrySize()

      for key,controller of @_registry
        controller.region.destroy()
      msg="There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"

    getRegistrySize: ->
      _.size @_registry

  App.commands.setHandler "register:instance", (instance,id) ->
    API.register instance,id if App.environment is "development"

  App.commands.setHandler "deregister:instance", (instance,id) ->
    API.deregister instance,id if App.environment is "development"

  App.commands.setHandler "reset:registry", ->
    API.resetRegistry()