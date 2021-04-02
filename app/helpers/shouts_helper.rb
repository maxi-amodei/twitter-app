module ShoutsHelper
  def avatar(user)
    username = user.username
    url = "https://kitt.lewagon.com/placeholder/users/#{username}"
    image_tag url
  end
end
