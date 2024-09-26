# frozen_string_literal: true

class User < ApplicationRecord
  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :email, uniqueness: { case_sensititive: true }
  validates :token, uniqueness: true

  before_create :generate_authentication_token!

  def generate_authentication_token!
    loop do
      self.token = Devise.friendly_token
      break unless self.class.exists?(token:)
    end
  end
end
