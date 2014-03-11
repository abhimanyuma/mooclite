@Mooclite.module "Views", (Views,App, Backbone,Marionette,$,_) ->

  _remove = Marionette.View::remove

  _.extend Marionette.View::,

    setInstancePropertiesFor: (args...) ->
      for key,val of _.pick(@options,args...)
        @[key] = val

    remove: (args...) ->
      console.log "removing", @
      _remove.apply @,args

    templateHelpers: ->

      linkTo: (name,url, options={}) ->
        _.defaults options,
          external: false

        url = "#" + url unless options.external
      
      currentUser:
        App.request("get:current:user").toJSON()