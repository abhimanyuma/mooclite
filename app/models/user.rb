class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :id, type: BigDecimal
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :created_at, type: Date
  field :updated_at, type: Date
  field :api_id, type: String
  field :api_secret, type: String


  index({ starred: 1 })

  include ActiveModel::SecurePassword
  include ActiveModel::MassAssignmentSecurity
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable



  before_save { self.email = email.downcase }

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false }


  has_secure_password
  attr_accessible :password , :password_confirmation
  attr_accessible :name, :email
  validates :password, presence: true,
                      confirmation: true,
                      length: { minimum: 6 }
  validates :password_confirmation, presence: { :if => :password }

end
