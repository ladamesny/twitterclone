class User < ActiveRecord::Base
  include Gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :statuses
  has_many :mentions

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'leader_id'
  has_many :leader_relationships, class_name:'Relationship', foreign_key: 'follower_id'

  has_many :follower_users, through: :follower_relationships, source: :follower
  has_many :following_users, through: :leader_relationships, source: :leader

	validates_presence_of :username, :email

  def num_unread_mentions
    mentions.where(viewed_at: nil).count
  end

  def unread_mentions
    mentions.where(viewed_at: nil)
  end

  def mark_unread_mentions!
    unread_mentions.each do |mention|
      mention.mark_viewed!
    end
  end

end
