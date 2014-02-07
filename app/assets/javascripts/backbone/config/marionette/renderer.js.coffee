do (Marionette) ->
  _.extend Marionette.Renderer, 

  root:"backbone/apps/"

  render: (template, data) ->
    path=JST[@root + template]
    throw "Template #{template} not found" unless path
    path(data) 


 