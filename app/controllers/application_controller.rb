class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    warden.user
  end

  helper_method :current_user

  def render500
    render 500, json: {}
  end

  def render404
    render 404, json: {}
  end

  def render402
    render 402, json: {}
  end

  def warden
    env['warden']
  end
end
