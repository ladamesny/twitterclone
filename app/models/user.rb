class User < ActiveRecord::Base
	has_secure_password

	has_many :statuses

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'leader_id'
  has_many :leader_relationships, class_name:'Relationship', foreign_key: 'follower_id'

  has_many :follower_users, through: :follower_relationships, source: :follower
  has_many :following_users, through: :leader_relationships, source: :leader

	validates_presence_of :username, :email
end
