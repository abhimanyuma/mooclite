@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  Edit.Controller = 

    edit: (id) ->
      course = App.request "course:entity", id

      App.execute "when:fetched", [course], =>
        editView = @getEditView course
        App.mainRegion.show editView

    getEditView: (course) -> 
      new Edit.Course
        model:course

  App.commands.setHandler "when:fetched", (entities,callback) ->
    xhrs=[]
    if _.isArray(entities)
      xhrs.push(entity._fetch) for entity in entities
    else
      xhrs.push(entities._fetch)
      
    $.when(xhrs...).done ->
      callback()
