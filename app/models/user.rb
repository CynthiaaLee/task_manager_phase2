class User < ApplicationRecord
    has_secure_password
    has_many :tasks, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  end
  