class Course

  include Mongoid::Document
  include Mongoid::Timestamps

  #attr_accessible :id,:name,:slug,:description,:offered_by,:bio, :created_at, :updated_at

  field :id, type: BigDecimal
  field :name, type: String
  field :slug, type: String
  field :description, type: String
  field :offered_by, type: String
  field :bio, type: String
  field :created_at, type: Date
  field :updated_at, type: Date

  index({ starred: 1 })

  validates_presence_of :name, :presence => true
  validates_uniqueness_of :_id
  validates_presence_of :offered_by ,:unless => proc {new_record?}
  validates_presence_of :bio ,:unless => proc {new_record?}
  validates :bio, :length => {maximum:140}

  belongs_to :user

  embeds_many :lectures

  def id_string
    return id.to_s
  end

end
