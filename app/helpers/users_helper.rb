module UsersHelper
  def users_count
    if User.count > 0
      return true
    else
      return false
    end
  end
end