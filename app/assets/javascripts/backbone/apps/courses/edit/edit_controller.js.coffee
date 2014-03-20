@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  Edit.Controller = 

    edit: (id) ->
      course = App.request "course:entity", id
      course.on "all", (e) -> 
        console.log e

      App.execute "when:fetched", [course], =>
        @layout = @getLayoutView course

        @layout.on "show", =>
          @titleRegion course
          @formRegion course

        App.mainRegion.show @layout

    titleRegion: (course) ->
      titleView = @getTitleView course

      @layout.titleRegion.show titleView

    formRegion: (course) ->
      editView= @getEditView course

      editView.on "form:cancel", ->
        App.vent.trigger "course:cancelled",course

      formView = App.request "form:wrapper", editView

      @layout.formRegion.show formView

    getLayoutView: (course) ->
      new Edit.Layout
        model:course

    getEditView: (course) ->
      new Edit.Course
        model:course

    getTitleView: (course) ->
      new Edit.Title
        model:course


