@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  Edit.Controller = 

    edit: (id) ->
      course = App.request "course:entity", id
      course.on "all", (e) -> 
        console.log e

      course.on "updated", ->
        App.vent.trigger "course:updated", course

      App.execute "when:fetched", [course], =>
        @layout = @getLayoutView course

        @layout.on "show", =>
          @titleRegion course
          @formRegion course

        App.mainRegion.show @layout

    titleRegion: (course) ->
      titleView = @getTitleView course

      titleView.on "course:delete:clicked", ->
        App.vent.trigger "course:delete", course

      @layout.titleRegion.show titleView



    formRegion: (course) ->
      editView= @getEditView course

      editView.on "form:cancel", ->
        App.vent.trigger "course:cancelled",course

      editView.on "bio:updated", =>
        @updateBio editView
                
           

      formView = App.request "form:wrapper", editView

      @layout.formRegion.show formView

      editView.trigger "bio:updated", course

    updateBio: (view) ->
      course = view.model
      gon.bio_length=view.$('#bio').val().length
      remaining_length=gon.bio_max-gon.bio_length
      view.$("#bio-length").text("#{remaining_length}")

      if (remaining_length<0)
          error={"bio":["is too long (maximum is 140 characters)"]}
          if course.has("_errors")
            errors=course.get("_errors")
            if errors["bio"] is null
              errors["bio"]=error["bio"]
              course.unset "_errors"
              course.set "_errors", errors
          else
            course.set "_errors", error 
      else
        if course.has("_errors")
          errors=course.get("_errors")
          delete errors["bio"]
          course.unset "_errors"

    getLayoutView: (course) ->
      new Edit.Layout
        model:course

    getEditView: (course) ->
      gon.bio_length=0
      gon.bio_max=140
      new Edit.Course
        model:course

    getTitleView: (course) ->
      new Edit.Title
        model:course
      

