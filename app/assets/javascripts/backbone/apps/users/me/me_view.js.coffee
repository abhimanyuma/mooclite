@Mooclite.module "UsersApp.Me", (Me, App, Backbone, Marionette, $, _) ->

  class Me.Layout extends App.Views.Layout
    template: "users/me/me_layout"

    regions:
      profileRegion: "#profile-region"
      apiKeyRegion: "#api-key-region"

  class Me.MeView extends App.Views.ItemView
    template: "users/me/me"

  class Me.EmptyApiKey extends App.Views.ItemView
    template: "users/me/_empty_apikey"

  class Me.ApiKey extends App.Views.ItemView

    template: "users/me/_apikey"
    tagName: "tr"
    className: "item"

    triggers:
      "click .delete-button": "delete:button:clicked"
      "click .delete-confirmation": "delete:confirmation:clicked"
      "click .delete-cancellation": "delete:cancellation:clicked"

    showConfirmationButtons: ->
      @$(".delete-button").hide()
      @$(".delete-confirmation").show()
      @$(".delete-cancellation").show()

    hideConfirmationButtons: ->
      @$(".delete-confirmation").hide()
      @$(".delete-cancellation").hide()
      @$(".delete-button").show()

    showLoadingDelete: ->
      @hideConfirmationButtons()
      @$(".delete-button").addClass("loading disabled")

    stopLoadingDelete: ->
      @hideConfirmationButtons()
      @$(".delete-button").removeClass("loading disabled")

  class Me.ApiKeys extends App.Views.CompositeView
    template: "users/me/_apikeys"
    childView: Me.ApiKey
    emptyView: Me.EmptyApiKey
    childViewContainer:"tbody"

    triggers:
      "click #create-new-api-key":"create:api:key:button:clicked"

    showLoadingAdd: ->
      @$("#create-new-api-key").addClass("loading disabled")

    stopLoadingAdd: ->
      @$("#create-new-api-key").removeClass("loading disabled")
