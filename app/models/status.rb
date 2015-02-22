class Status < ActiveRecord::Base
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

	validates_presence_of :creator
	validates_presence_of :body
end