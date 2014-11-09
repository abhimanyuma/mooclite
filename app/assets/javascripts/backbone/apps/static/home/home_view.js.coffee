@Mooclite.module "StaticApp.Home", (Home, App, Backbone, Marionette, $, _) ->

  class Home.Layout extends Marionette.Layout
    template: "static/home/home"

    triggers:
      "click #home-signup-button": "new:user:button:clicked"
      "click #home-login-button" : "login:user:button:clicked"
