class User < ActiveRecord::Base
  # Include default devise modules.
  # acts_as_token_authenticatable
  before_validation :set_provider
  before_validation :set_uid

  def set_provider
    self[:provider] = "email" if self[:provider].blank?
  end

  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_many :messages

  def self.get_user(client_id, token)
  	user = User.where(client_id: client_id).first rescue nil
  	if user
  		user.tokens[client_id]["token"] == token ? user : nil
  	end
  end
end
