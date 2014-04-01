@Mooclite.module "Components.Loading" , (Loading, App, Backbone, Marionette, $, _) ->

  class Loading.LoadingView extends App.Views.ItemView

    template: "loading/wrapper"
    className: "ui dimmable dimmed segment loading-container"

    onShow: ->
      opts = @_getOptions()
      @$("#spin-div").spin opts

    _getOptions: ->
      lines: 17
      length: 0
      width: 21
      radius: 11
      corners: 1
      rotate: 30
      direction: 1
      color: '#fff'
      speed: 1
      trail: 10
      shadow: true
      hwaccel: false
      className: 'spinner'
      zIndex: 2e9
      top: 'auto'
      left: 'auto'