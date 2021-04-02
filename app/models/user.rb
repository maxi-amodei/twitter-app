class User < ApplicationRecord
  include Clearance::User

  validates :username, presence: :true, uniqueness: true
  has_many :shouts, dependent: :destroy

  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  # The likes model will have: user_id and shout_id

  def like(shout)
    # este liked_shouts lo defino en la asociacion has_many through
    liked_shouts << shout
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end
  
  def liked?(shout)
    # Quiero saber si liked_shouts contiene al shout
    liked_shout_ids.include?(shout.id)
  end

  def to_param
    # Esto es para que en los params se pase el username y no el id user/1 vs. user/maxi-amodei
    #Ahora resta cambiar el User controller y poner find_by_username
    username
  end
end
