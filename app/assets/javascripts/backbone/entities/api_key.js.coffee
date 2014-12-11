@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.ApiKey extends Entities.Model
    urlRoot: ->
      if @collection && @collection.user_id
        Routes.user_api_key_index_path(@collection.user_id)
      else if @user_id
        Routes.user_api_key_index_path(@user_id)


  class Entities.ApiKeyCollection extends Entities.Collection
    model:Entities.ApiKey
    url: -> Routes.user_api_key_index_path(@user_id)

  API=
    getApiKeyCollection:(user_id)  ->
      api_keys= new Entities.ApiKeyCollection
        user_id: user_id
      api_keys.fetch()
      api_keys

    getApiKey: (user_id,id) ->
      api_key = new Entities.ApiKey
        id: id
        user_id: user_id
      api_key.fetch()
      api_key

    newApiKey: (user_id) ->
      new Entities.ApiKey
        user_id: user_id

    createApiKeys: (data,user_id) ->
      api_keys = new Entities.ApiKeyCollection(data)
      for model in api_keys.models
        model.user_id = user_id
        model.collection = api_keys

      api_keys



  App.reqres.setHandler "api_key:entity", (user_id,id) ->
    API.getApiKey(user_id,id)

  App.reqres.setHandler "api_key:entities", (user_id) ->
    API.getApiKeyCollection(user_id)

  App.reqres.setHandler "new:api_key", (user_id) ->
    API.newApiKey(user_id)

  App.reqres.setHandler "create:api_keys", (data,user_id) ->
    API.createApiKeys(data,user_id)
