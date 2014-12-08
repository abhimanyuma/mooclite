@Mooclite.module "HeaderApp.List", (List,App,Backbone,Marionette,$,_) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->

      { navs } = options

      @layout = @getLayoutView()

      currentUser = App.request "current:user"

      App.execute "when:fetched", currentUser, =>
        @layout.render()
        @showLoginPatch(currentUser)

      @listenTo @layout, "show", =>
        # @showList navs
        @showLoginPatch(currentUser)

      @show @layout,
        loading: false

    showList: (links) ->
      listView = @getListView links
      @layout.listRegion.show listView

    getListView: (links) ->
      new List.Headers
        collection: links

    showLoginPatch:(user) ->
      loginPatchView = @getLoginPatchView(user)
      @layout.loginPatchRegion.show loginPatchView

    getLoginPatchView: (user) ->
      new List.LoginPatch
        model: user

    getLayoutView: ->
      new List.Layout