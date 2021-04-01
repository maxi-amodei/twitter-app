class Shout < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: {in: 1..144}
  validates :user, presence: true

  #Asi ordeno el listado de mensages en otro orden
  default_scope { order(created_at: :desc) }

  delegate :username, to: :user
  # def username
  #   self.user.username
  # end
end
