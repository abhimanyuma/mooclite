class ApiKey
  include Mongoid::Document

  field :key, type: String
  field :secret, type: String

  embedded_in :user
end
