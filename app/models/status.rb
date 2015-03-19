class Status < ActiveRecord::Base
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

	validates_presence_of :creator
	validates_presence_of :body

  after_save :extract_mentions

  def extract_mentions
    mentions = self.body.scan(/@(\w*)/)
    if mentions.size > 0
      mentions.each do |mention|
        if User.find_by username: mention[0]
          create_mention(User.find_by username: mention[0])
        end
      end
    end
  end

  def create_mention user
    Mention.create(user: user, status: self)
  end
end
