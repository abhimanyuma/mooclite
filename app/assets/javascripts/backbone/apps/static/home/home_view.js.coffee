@Mooclite.module "StaticApp.Home", (Home, App, Backbone, Marionette, $, _) ->

  class Home.Layout extends Marionette.Layout
    template: "static/home/home"
