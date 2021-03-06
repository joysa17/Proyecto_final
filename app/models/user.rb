class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

	has_many :orders
	has_many :billings
	has_many :products, through: :orders
	has_many :posts

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		 user.email = auth.info.email
		 user.password = Devise.friendly_token[0,20]
		 #user.name = auth.info.name
		end
	end

	def is_admin?
    	current_user.admin == 1
 	end
end
