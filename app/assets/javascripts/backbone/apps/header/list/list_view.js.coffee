 @Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Header extends App.Views.ItemView
    template: "header/list/templates/_header"
    tagName: "a"
    className: "item" 
    attributes: {"href":"#"}

  class List.Headers extends App.Views.CompositeView
    template: "header/list/templates/list_headers"
    itemView: List.Header
    itemViewContainer: "div#links"