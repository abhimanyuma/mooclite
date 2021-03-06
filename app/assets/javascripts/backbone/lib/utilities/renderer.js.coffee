@Mooclite.module "Utilities", (Utilities,App, Backbone, Marionette, $, _) ->

  _.extend Marionette.Renderer, 
 
    lookups: ["backbone/apps/", "backbone/lib/components/"]

    templated: (path) ->
      path_elems = path.split("/")
      path_elems.splice(-1,0,"templates")
      path_elems.join("/")

    render: (template, data) ->
      return unless template 
      path= @getTemplate(template)
      throw "Template #{template} not found" unless path
      path(data) 

    getTemplate: (template) ->
      for path in [template, @templated(template)]
        for lookup in @lookups
          return JST[lookup + path] if JST[lookup + path]
