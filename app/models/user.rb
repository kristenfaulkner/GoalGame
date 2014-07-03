class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, presence: true
  validates :password, length: {minimum: 6}, on: :create
  validates :username, uniqueness: true
  
  has_many :goals
  
  def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest)
    bcrypt_password.is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save!
  end
  
  def self.generate_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def reset_token!
    self.token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.token
  end
end
