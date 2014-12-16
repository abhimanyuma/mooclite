@Mooclite.module "LecturesApp.UpdateFiles", (UpdateFiles, App, Backbone, Marionette, $, _) ->

  class UpdateFiles.Update extends App.Views.ItemView

    template: "lectures/update_files/update_files"

    triggers:
      "click .cancel-update-files": "cancel:update:file:button:clicked"
      "click .submit-update-files": "submit:update:file:button:clicked"