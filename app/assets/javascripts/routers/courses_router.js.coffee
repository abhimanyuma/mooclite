class Mooclite.Routers.Courses extends Backbone.Router
  routes:
    '': 'index'
    'courses/:id': 'show'

  index: ->
    view = new Mooclite.Views.CoursesIndex()
    $('#container').html(view.render().el)

  show: (id) ->
    alert "This is No.#{id} here"