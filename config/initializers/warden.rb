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


  def authenticate!

    errors = {}

    if params['password'].blank?
       errors[:password] = ["cannot be blank"]
    end

    if params['email'].blank?
      errors[:email] = ["cannot be blank"]
    end

    return fail(errors) unless errors.empty?

    user = User.where(email: params['email']).first

    if user
      if user.authenticate(params['password'])
        return success!(user)
      else
        errors[:password] = ["is not valid"]
      end
    end

    if user.nil?
      errors[:email] = ["does not exist"]
    end

    fail errors
  end
end