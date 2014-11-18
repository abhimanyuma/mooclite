@Mooclite.module "Components.Authentication" , (Authentication, App, Backbone, Marionette, $, _) ->

  class Authentication.View extends App.Views.Layout
    template: "authentication/login"
