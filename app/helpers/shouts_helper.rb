module ShoutsHelper
  def avatar(user)
    username = user.username
    url = "https://kitt.lewagon.com/placeholder/users/#{username}"
    image_tag url
  end

  def like_button(shout)
    if current_user.liked?(shout)
      link_to "Unlike", unlike_shout_path(shout), method: :delete
    else
      link_to "Like", like_shout_path(shout), method: :post
    end  
  end
end
