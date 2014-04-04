 @Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Header extends App.Views.ItemView
    template: "header/list/templates/_header"
    tagName: "a"
    className: "red item" 
    attributes: {"href": "#"}

    modelEvents:
      "change:chosen" :  "changeChosen"

    onBeforeRender: ->
      @$el.attr("href","#{@model.get('url')}")

    changeChosen: (model,value,options) ->
      @$el.toggleClass "active", value 

  class List.Headers extends App.Views.CompositeView
    template: "header/list/templates/list_headers"
    itemView: List.Header
    itemViewContainer: "div#links"