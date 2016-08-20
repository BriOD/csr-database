class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info

    user = User.where(provider: access_token.provider, uid: access_token.uid).first
    return user if user

    registered_user = User.where(email: access_token.info.email).first
    return registered_user if registered_user

    User.create(
      name: data['name'],
      provider: access_token.provider,
      email: data['email'],
      uid: access_token.uid,
      password: Devise.friendly_token[0, 20]
    )
  end
end
