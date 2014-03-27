class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase }

  validates :name, presence: true, 
                   length: { maximum: 50 }
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    email: true
  

  has_secure_password
  validates :password, presence: true, 
                       confirmation: true, 
                       length: { minimum: 6 }
  validates :password_confirmation, presence: { :if => :password }

end
