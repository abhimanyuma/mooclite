class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include ActiveModel::SecurePassword
  include ActiveModel::MassAssignmentSecurity
  attr_accessible :name, :email
  attr_accessible :password, :password_confirmation
  has_secure_password


  field :id, type: BigDecimal
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :created_at, type: Date
  field :updated_at, type: Date
  embeds_many :api_keys
  has_many :courses


  index({ starred: 1 })

  before_save { self.email = email.downcase }

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                      confirmation: true,
                      length: { minimum: 6 },
                      if: :password_required?
  validates :password_confirmation, presence: { :if => :password }

  def owns? (user_id)
    return false if user_id.nil?
    if self.id == user_id
      return true
    elsif User.where(:id => user_id).first
      User.where(:id => user_id).first.admin?
    else
      return false
    end
  end

  def password_required?
    self.new_record? or self.password
  end

  def admin?
    return false
  end

  def create_api_key
    key = SecureRandom.hex(16)
    secret = SecureRandom.base64(32)
    self.api_keys.create( key: key, secret: secret)
    self.save
  end

  def remove_api_key(key)
    if self.api_keys
      self.api_keys.where(key: key).destroy_all
      self.save
    end
  end


end
