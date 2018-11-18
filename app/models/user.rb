class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true,
                       length: { minimum: 8 }
end
