class User < ApplicationRecord
  include Clearance::User

  validates :username, presence: :true, uniqueness: true
  has_many :shouts, dependent: :destroy

  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  # The likes model will have: user_id and shout_id

  #Relationship between user and following relationship is through user_id and follower_id
  # The following command : user_1.followed_users does the following:
    # For user_1 with follower_id = user_id = 1 
    # it looks for all the users with user_id = followed_user_id
    # SELECT * FROM users
    # (JOIN is on user_id = followed_user_id)
    # (WHERE follower_id = 1) Para el user/follower 1, trame todos los followed
  has_many :followed_user_relationships, foreign_key: :follower_id, class_name: "FollowingRelationship", dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships


  # Rails trata de averiguar la clase de la asociacion
  # Como follower_relationship no existe, le agrego  class_name: "FollowingRelationship"
  # Esto me genera la asociacion para traerme a quienes ME SIGUEN, followers
  
  # For user_1 with followed_user_id = user_id = 1 
    # it looks for all the users with user_id = follower_id
    # SELECT * FROM users
    # (JOIN is on user_id = follower_id)
    # (WHERE followed_user_id = 1) Para el user/follower 1, trame todos los que me tienen como followed

  has_many :follower_relationships, foreign_key: :followed_user_id, class_name: "FollowingRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  def timeline_shouts
    Shout.where(user_id: followed_user_ids + [id])
  end

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.destroy(user)
  end

  def like(shout)
    # este liked_shouts lo defino en la asociacion has_many through
    liked_shouts << shout
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end
  
  def liked?(shout)
    # Quiero saber si liked_shouts contiene al shout, el metodo liked_shout_ids viene de la asociacion HAS_MANY
    liked_shout_ids.include?(shout.id)
  end

  def following?(user)
    followed_user_ids.include?(user.id)
  end

  def to_param
    # Esto es para que en los params se pase el username y no el id user/1 vs. user/maxi-amodei
    #Ahora resta cambiar el User controller y poner find_by_username
    username
  end
end
