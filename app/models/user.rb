class User < ApplicationRecord
	has_many :logs, dependent: :destroy

	before_save { self.email = email.downcase! }

	validates :name, presence: true, length: { maximum: 50 }
	validates :username, presence: true, length: { maximum: 30 }, uniqueness: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 
				presence: true, 
				length: { maximum: 50 },
				format: { with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	def log_list
		Log.where("user_id = ?", id)
	end
end
