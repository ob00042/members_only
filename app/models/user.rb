class User < ApplicationRecord
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true, length: { minimum: 6 }
	before_create :create_remember_digest

	def self.create_token
  	SecureRandom.urlsafe_base64
  end

  def self.digest_token(string)
  	Digest::SHA1.hexdigest(string.to_s)
  end


  def create_remember_digest
  	self.remember_digest = User.digest_token(User.create_token)
  end
end
