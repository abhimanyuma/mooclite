class Mooclite.Views.CoursesIndex extends Backbone.View

  template: JST['courses/index']

  events: 
    'submit #new_course' : 'createCourse' 

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add',@appendCourse,this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendCourse)
    this

  appendCourse: (course) ->
    view = new Mooclite.Views.Course(model: course)
    $('#courses').append(view.render().el)

  createCourse: (event) ->
    event.preventDefault()
    @collection.create({ name: $('#new_course_name').val(),offered_by: $('#new_course_offered_by').val(),description: $('#new_course_description').val(),bio: $('#new_course_bio').val()})
 