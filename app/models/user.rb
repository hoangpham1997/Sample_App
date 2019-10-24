class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex

  before_save{email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.max_length_name}
  validates :email, presence: true,
    length: {maximum: Settings.max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :password, presence: true, length: {minimum: Settings.minimum_pw}

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
