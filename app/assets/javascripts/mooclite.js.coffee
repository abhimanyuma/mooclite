window.Mooclite =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	new Mooclite.Routers.Courses()
  	Backbone.history.start()

$(document).ready ->
  Mooclite.initialize()
