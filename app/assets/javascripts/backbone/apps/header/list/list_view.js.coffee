 @Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Header extends App.Views.ItemView
    template: "header/list/templates/_header"
    tagName: "a"
    className: "red item" 
    attributes: {"href": "#"}

    events:
      "click" : "choose"

    modelEvents:
      "change:chosen" :  "changeChosen"

    onBeforeRender: ->
      @$el.attr("href","#{@model.get('url')}")

    choose: ->
      App.vent.trigger "nav:choose", @model.get('name')

    changeChosen: (model,value,options) ->
      @$el.toggleClass "active", value 

  class List.Headers extends App.Views.CompositeView
    template: "header/list/templates/list_headers"
    itemView: List.Header
    itemViewContainer: "div#links"