class Course

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  field :id, type: BigDecimal
  field :name, type: String
  field :slug, type: String
  field :description, type: String
  field :offered_by, type: String
  field :bio, type: String
  field :created_at, type: Date
  field :updated_at, type: Date

  field :_id, type: String, default: ->{ name.to_s.parameterize }

  validates_presence_of :name, :presence => true
  validates_uniqueness_of :_id
  validates_presence_of :offered_by ,:unless => proc {new_record?}
  validates_presence_of :bio ,:unless => proc {new_record?}
  validates :bio, :length => {maximum:140}

  before_validation(on: :create) do
    self._id = self.name.parameterize
  end

  has_many :lectures, dependent: :destroy

  private

end
