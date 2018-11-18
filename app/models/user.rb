class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true,
                       length: { minimum: 8 }
  validates :username, length: { minimum: 5 },
                       on: :update

  before_save :set_default_username

  def set_default_username
    self.username = email.split('@')[0] if new_record?
  end
end
