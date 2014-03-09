@Mooclite.module "Entities", (Entities, App, Backbone, Marionette,$, _) ->

  class Entities.Button extends Entities.Model

  class Entities.ButtonsCollection extends Entities.Collection
    model: Entities.Button

  API =
    getFormButtons : (buttons, model) ->
      buttons = @getDefaultButtons buttons, model
      
      buttonArray = []
      buttonArray.push {type: "cancel", className: "#{buttons.cancelClass} ui button",text: buttons.cancel}
      buttonArray.push {type: "primary", className:"#{buttons.primaryClass} ui button", text: buttons.primary}

      buttonArray.reverse() if buttons.placement is "left"

      buttonCollection = new Entities.ButtonsCollection buttonArray
      buttonCollection.placement = buttons.placement

      buttonCollection

    getDefaultButtons: (buttons, model) ->
      _.defaults buttons,
        primary: if model.isNew() then "Create" else "Update"
        primaryClass: "positive"
        cancel: "Cancel"
        cancelClass: "negative"
        placement: "right"


  App.reqres.setHandler "form:button:entities" , (buttons = {}, model) ->
    API.getFormButtons buttons, model