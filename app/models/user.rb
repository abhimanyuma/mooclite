class User < ActiveRecord::Base

  has_secure_password

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true
  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => { :if => :password }

  
end
