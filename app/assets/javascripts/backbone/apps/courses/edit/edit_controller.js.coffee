@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  Edit.Controller = 

    edit: (id) ->
      course = App.request "course:entity", id

      App.execute "when:fetched", [course], =>
        @layout = @getLayoutView course

        @layout.on "show", =>
          @formRegion course

        App.mainRegion.show @layout

    formRegion: (course) ->
      editView= @getEditView course

      formView = App.request "form:wrapper", editView

      @layout.formRegion.show formView

    getLayoutView: (course) ->
      new Edit.Layout
        model:course

    getEditView: (course) ->
      new Edit.Course
        model:course


