module Warden::Mixins::Common
  def request
    @request ||= ActionDispatch::Request.new(@env)
  end
end

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = lambda { |env| SessionsController.action(:failed).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end


Warden::Strategies.add(:password) do
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = User.where(email: params['email']).first
    if user && user.authenticate(params['password'])
      success! user
    else
      fail "Authentication unsuccessful"
    end
  end
end