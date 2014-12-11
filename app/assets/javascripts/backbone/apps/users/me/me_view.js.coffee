@Mooclite.module "UsersApp.Me", (Me, App, Backbone, Marionette, $, _) ->

  class Me.Layout extends App.Views.Layout
    template: "users/me/me_layout"

    regions:
      profileRegion: "#profile-region"
      apiKeyRegion: "#api-key-region"

  class Me.MeView extends App.Views.ItemView

    template: "users/me/me"

    triggers:
      "click #create-new-api-key":"create:api:key:button:clicked"

  class Me.EmptyApiKey extends App.Views.ItemView
    template: "users/me/_empty_apikey"

  class Me.ApiKey extends App.Views.ItemView

    template: "users/me/_apikey"
    tagName: "tr"
    className: "item"


  class Me.ApiKeys extends App.Views.CompositeView
    template: "users/me/_apikeys"
    childView: Me.ApiKey
    emptyView: Me.EmptyApiKey
    childViewContainer:"tbody"
