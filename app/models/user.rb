class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, 
            :first_name, 
            :last_name, 
            :password, 
            :password_confirmation

  validates(:first_name, :last_name, presence: true, length: { maximum: 50 })
  validates(:password, presence: true, length: { minimum: 6 })
  validates(:password_confirmation, presence: true)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, 
            uniqueness: { case_sensitive: false }, 
            format: { with: VALID_EMAIL_REGEX })
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end