do (Backbone) ->

  _.extend Backbone.Marionette.Application::,

    navigate: (route,options={}) ->
      route = route.substring(5,-1) if route.substring(0,4) == "/api"
      route = "#" + route if route.charAt(0) is "/"
      Backbone.history.navigate route,options

    getCurrentRoute: ->
      frag = Backbone.history.fragment
      if _.isEmpty(frag) then null else frag

    startHistory: ->
      if Backbone.history
        Backbone.history.start()
