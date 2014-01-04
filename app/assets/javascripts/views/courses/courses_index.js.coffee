class Mooclite.Views.CoursesIndex extends Backbone.View

  template: JST['courses/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(courses: @collection))
    this
 