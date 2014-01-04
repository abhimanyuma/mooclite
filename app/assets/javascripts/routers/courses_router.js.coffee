class Mooclite.Routers.Courses extends Backbone.Router
  routes:
    '': 'index'
    'courses/:id': 'show'

  initialize: ->
    @collection = new Mooclite.Collections.Courses()
    @collection.fetch({reset: true})

  index: ->
    view = new Mooclite.Views.CoursesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "This is No.#{id} here"