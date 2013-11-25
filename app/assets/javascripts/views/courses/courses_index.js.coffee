class Mooclite.Views.CoursesIndex extends Backbone.View

  template: JST['courses/index']

  render: ->
    $(@el).html(@template(entries: "Some text here"))
    this
