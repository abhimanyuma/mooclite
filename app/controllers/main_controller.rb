class MainController < ApplicationController
  def index
    @users = User.all
    gon.rabl "app/views/users/index.json.rabl", as: "users"
    gon.foo = "bar"
  end
end
