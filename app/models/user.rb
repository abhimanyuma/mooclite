class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :_id, type: BigDecimal, default: ->{id.to_i.parameterize}

  field :id, type: BigDecimal
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :institute, type: String
  field :role, type: String
  field :slug, type: String
  field :created_at, type: Date
  field :updated_at, type: Date
  field :api_id, type: String
  field :api_secret, type: String

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
  validates :password, presence: true,
                      confirmation: true,
                      length: { minimum: 6 }
  validates :password_confirmation, presence: { :if => :password }

end
