@Mooclite.module "LecturesApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  class List.Empty extends App.Views.ItemView
    tagName: "tr"
    template: "lectures/list/_empty"

  class List.Lecture extends App.Views.ItemView

    template: "lectures/list/_lecture"
    tagName: "tr"
    className: "item"

    triggers:
      "click .lecture-name" : "lecture:clicked"
      "click .delete-button" : "delete:lecture:button:clicked"
      "click .delete-confirmation" : "delete:lecture:confirmation:clicked"
      "click .delete-cancellation" : "delete:lecture:cancellation:clicked"

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

  class List.Lectures extends App.Views.CompositeView
    template: "lectures/list/_lectures"
    childView: List.Lecture
    emptyView: List.Empty
    childViewContainer:"tbody"

    triggers:
      "click #create-new-lecture": "new:lecture:button:clicked"