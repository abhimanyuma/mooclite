class MainController < ApplicationController
  def index
    @user = User.first
    gon.rabl "app/views/users/show.json.rabl", as: "current_user"

  end
end
