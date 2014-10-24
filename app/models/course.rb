class Course

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :_id, type: BigDecimal, default: ->{name.parameterize}

  field :id, type: BigDecimal
  field :name, type: String
  field :slug, type: String
  field :description, type: String
  field :offered_by, type: String
  field :bio, type: String
  field :created_at, type: Date
  field :updated_at, type: Date

  validates_presence_of :name, :presence => true
  validates_presence_of :offered_by ,:unless => proc {new_record?}
  validates_presence_of :bio ,:unless => proc {new_record?}
  validates :bio, :length => {maximum:140}


  has_many :lectures, dependent: :destroy
end
