@Mooclite.module "UsersApp.List", (List, App,Backbone, Marionette,$,_) -> 

  class List.Layout extends App.Views.Layout
    template: "users/list/templates/list_layout"

    regions:
      panelRegion: "#panel-region"
      usersRegion: "#users-region"

  class List.Panel extends App.Views.ItemView 
    template: "users/list/templates/_panel"
    collectionEvents:
      "reset" : "render"

  class List.Empty extends App.Views.ItemView
    template: "users/list/templates/_empty"


  class List.User extends App.Views.ItemView
    template: "users/list/templates/_user"
    className: "item"


  class List.Users extends App.Views.CompositeView
    template: "users/list/templates/_users"
    itemView: List.User
    emptyView: List.Empty
    itemViewContainer: "div#user-list"