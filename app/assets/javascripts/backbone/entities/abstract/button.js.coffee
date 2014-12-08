@Mooclite.module "Entities", (Entities, App, Backbone, Marionette,$, _) ->

  class Entities.Button extends Entities.Model

  class Entities.ButtonsCollection extends Entities.Collection
    model: Entities.Button

  API =
    getFormButtons : (buttons, model) ->
      buttons = @getDefaultButtons buttons, model

      buttonArray = []
      buttonArray.push {data: "cancel", className: "#{buttons.cancelClass}",text: buttons.cancel, type: buttons.type} unless buttons.cancel is false
      buttonArray.push {data: "primary", className:"#{buttons.primaryClass}", text: buttons.primary, type: buttons.primaryType} unless buttons.primary is false

      buttonArray.reverse() if buttons.placement is "left"

      buttonCollection = new Entities.ButtonsCollection buttonArray
      buttonCollection.placement = buttons.placement

      buttonCollection

    getDefaultButtons: (buttons, model) ->
      _.defaults buttons,
        primary: if model.isNew() then "Create" else "Update"
        primaryType: "submit"
        primaryClass: "positive"
        cancel: "Cancel"
        cancelClass: "negative"
        type:"button"
        placement: "right"

    getLoginButtons: (buttons) ->
      buttons = @getDefaultLoginButtons buttons

      buttonArray = []
      buttonArray.push {data: "login", className: "#{buttons.loginClass}", text: buttons.login, type: buttons.loginType} unless buttons.login is false

      buttonCollection = new Entities.ButtonsCollection buttonArray
      buttonCollection.placement = buttons.placement

      buttonCollection

    getDefaultLoginButtons: (buttons) ->
      _.defaults buttons,
        loginClass: "login-button positive"
        login: "Login"
        loginType: "submit"


  App.reqres.setHandler "form:button:entities" , (buttons = {}, model) ->
    API.getFormButtons buttons, model

  App.reqres.setHandler "login:button:entities" , (buttons = {}) ->
    API.getLoginButtons buttons