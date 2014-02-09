@Mooclite.module "FooterApp.Show", (Show,App,Backbone,Marionette,$,_) ->

  Show.Controller =

    show: -> 
      currentUser = App.request "get:current:user"
      footerView = @getView currentUser
      App.footerRegion.show footerView

    getView: (currentUser) ->
      new Show.Footer
        model: currentUser