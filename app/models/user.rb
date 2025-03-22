class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_authentication_token

  private

  def generate_authentication_token
    self.authentication_token ||= SecureRandom.hex(20)
  end
end
