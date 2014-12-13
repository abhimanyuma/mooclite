class ApiKey
  include Mongoid::Document

  field :key, type: String
  field :secret, type: String

  embedded_in :user

  def as_json(options={})
    reply = super(options.merge(
        methods: [:id_string],
        only: [:key, :secret]
      ))
    reply["id"] = reply["id_string"]
    reply.delete("id_string")
    reply
  end

  def id_string
    return id.to_s
  end
end
