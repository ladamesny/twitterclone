module UserHelper
  def following_user?(user)
    current_user.following_users.include?(user) ? true : false
  end
end
