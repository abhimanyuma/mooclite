window.Mooclite =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	new Mooclite.Routers.Dashboard()
  	Backbone.history.start()

$(document).ready ->
  Mooclite.initialize()
