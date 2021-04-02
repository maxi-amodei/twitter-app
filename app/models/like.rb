class Like < ApplicationRecord
  belongs_to :user
  belongs_to :shout

  # Valido que haya un solo like por shout per user, unique pair
  validates :user_id, uniqueness: { scope: :shout_id }
end
