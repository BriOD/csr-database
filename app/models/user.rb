# ==============================================================================
# Users Table
#
# first_name, last_name, email, encrypted_password, provider, uid
# ==============================================================================
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates_presence_of :first_name, :last_name

  def self.find_for_google_oauth2(access_token, _signed_in_resource = nil)
    # data = access_token.info

    user = User.where(provider: access_token.provider, uid: access_token.uid).first
    return user if user

    # registered_user = User.where(email: access_token.info.email).first
    # return registered_user if registered_user

    User.create(
      first_name: access_token.info['first_name'],
      last_name: access_token.info['last_name'],
      provider: access_token.provider,
      email: access_token.info['email'],
      uid: access_token.uid,
      password: Devise.friendly_token[0, 20]
    )
  end

  def name
    "#{first_name} #{last_name}"
  end
end
