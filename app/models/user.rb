class User < ActiveRecord::Base
	has_secure_password

	has_many :statuses

	validates_presence_of :username
end