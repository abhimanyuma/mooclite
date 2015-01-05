@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "lectures/show/show_layout"

    regions:
      titleRegion: "#title-region"
      contentRegion: "#content-region"
      videoRegion: "#video-region"

  class Show.Content extends App.Views.ItemView

    template: "lectures/show/show_content"
    className: "ui segment"

  class Show.Title extends App.Views.ItemView
    template: "lectures/show/show_title"
    className: "ui segment"

    triggers:
      "click #edit-lecture-button" : "edit:lecture:button:clicked"
      "click #update-files-lecture-button" : "update:files:lecture:button:clicked"

  class Show.Video extends App.Views.ItemView
    template: "lectures/show/show_video"
    className: "ui segment"

    onRender: ->
      window.setTimeout =>
        new window.Moocplayer(".moocplayer-container",@model)