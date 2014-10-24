class BaseModel

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :_id, type: BigDecimal, default: ->{id.to_i.parameterize}

end