@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.Model extends Backbone.Model

    save: (data,options = {}) ->
      _.defaults options,
        wait:true

      super data,options