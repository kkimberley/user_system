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

  def send_password_reset_email
    generate_token(:reset_digest)
    self.reset_send_at = Time.zone.now
    save!(validate: false)

    UserMailer.password_reset_email(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
