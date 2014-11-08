@Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->

      { navs } = options

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        # @showList navs
        @showLoginPatch()

      @show @layout

    showList: (links) ->
      listView = @getListView links
      @layout.listRegion.show listView

    getListView: (links) ->
      new List.Headers
        collection: links

    showLoginPatch: ->
      loginPatchView = @getLoginPatchView()
      @layout.loginPatchRegion.show loginPatchView

    getLoginPatchView: ->
      new List.LoginPatch

    getLayoutView: ->
      new List.Layout