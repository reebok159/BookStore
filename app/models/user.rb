class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :reviews
  has_many :orders
  has_one :shipping_address, dependent: :destroy
  accepts_nested_attributes_for :shipping_address, allow_destroy: true
  has_one :billing_address, dependent: :destroy
  accepts_nested_attributes_for :billing_address, allow_destroy: true

  validates :email,  format: { with: %r{\A[^-.]\w+[-.]?(\w+[-!#$%&'*+\/=?^_`{|}~.]\w+)*[^-]@([\w\d]+)\.([\w\d]+)\z} }, uniqueness: true
  validates :email, presence: true
  validates_confirmation_of :password
  validates :password, presence: true, unless: ->(u) { u.password.nil? }
  #validates :password, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])[\w-]{8,}/,
                                 #message: I18n.t('validations.password.format') }, unless: ->(u) { u.password.nil? }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      #user.name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["device.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end

