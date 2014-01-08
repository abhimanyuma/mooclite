class Mooclite.Views.Course extends Backbone.View

  template: JST['courses/course']
  className: 'item'
    
  render: ->
    $(@el).html(@template(course: @model))
    this