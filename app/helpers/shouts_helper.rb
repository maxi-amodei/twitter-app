module ShoutsHelper
  
  def like_button(shout)
    if current_user.liked?(shout)
      link_to "Unlike", unlike_shout_path(shout), method: :delete
    else
      link_to "Like", like_shout_path(shout), method: :post
    end  
  end

  def autolink(text)
    text.
      gsub(/@\w+\D?\w+/) { |mention| link_to mention, user_path(mention[1..-1]) }.
      gsub(/#\w+\D?\w+/) { |hashtag| link_to hashtag, hashtag_path(hashtag[1..-1]) }.
      html_safe
  end
end
