# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :billing_address, as: :billing_a, dependent: :destroy
  has_one :shipping_address, as: :shipping_a, dependent: :destroy

  validates :email, presence: true, email: true, uniqueness: true
  validates :password, confirmation: true
  validates :password, presence: true, unless: ->(u) { u.password.nil? }

  def self.from_omniauth(auth)
    registered = where(email: auth.info.email).first
    return registered.add_omni(auth) if registered.present?

    where(provider: auth.provider, uid: auth.uid).first_or_initialize { |u| u.save_data_from_omni(auth) }
  end

  private

  def save_data_from_omni(auth)
    self.email = auth.info.email
    self.password = Devise.friendly_token[0, 20]
    skip_confirmation!
    save!
  end

  def add_omni(auth)
    update(provider: auth.provider, uid: auth.uid)
    confirm unless confirmed?
    self
  end
end
