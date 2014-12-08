@Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Layout extends Marionette.LayoutView
    template: "header/list/layout"
    regions:
      listRegion: "#list-region"
      loginPatchRegion: "#login-patch-region"

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

  class List.Headers extends App.Views.CollectionView
    childView: List.Header
    childViewContainer: "div#links"

  class List.LoginPatch extends App.Views.ItemView
    template: "header/list/login_patch"

    triggers:
      "click .navbar-login":"navbar:login:clicked"
      "click .navbar-logout":"navbar:logout:clicked"
