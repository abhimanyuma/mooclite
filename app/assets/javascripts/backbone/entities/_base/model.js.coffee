@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.Model extends Backbone.Model

    save: (data,options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait:true
        success: _.bind(@saveSuccess,@,isNew,options.collection)


      super data,options

    saveSuccess: (isNew,collection) ->
      if isNew ##Model is created
        collection.add @ if collection
        collection.trigger "model:created", @ if collection
        @trigger "created",@
      else
        collection ?= @collection
        collection.trigger "model:updated", @ if collection
        @trigger "updated",@