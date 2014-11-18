do (Backbone) ->
  _sync = Backbone.sync
  Backbone.sync = (method, entity, options ={}) ->

    _.defaults options,

      beforeSend: (xhr) ->
        entity.trigger "sync:start", entity
        token = $('meta[name="csrf-token"]').attr('content');
        xhr.setRequestHeader('X-CSRFToken', token);

      complete: ->
        entity.trigger "sync:stop", entity

    sync= _sync(method, entity, options)
    if !entity._fetch and method is "read"
      entity._fetch = sync

