class User < ApplicationRecord
  before_save :lower_case
  has_many :rentals
  enum role: %w(admin user).index_with(&:to_s)
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, presence: true, uniqueness: true, length: { is: 10 },format: { with: /\A[0-9]+\z/, message: "only allows numbers" }
  validates :d_license_no, presence: true, uniqueness: true
  validates :address, presence: true
  has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }

  private
    def lower_case
      self.email = self.email.downcase
      self.name = self.name.downcase
      self.address = self.address.downcase
    end
end
