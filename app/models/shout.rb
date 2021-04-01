class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates :user, presence: true

  #Asi ordeno el listado de mensages en otro orden
  default_scope { order(created_at: :desc) }

  delegate :username, to: :user
  # def username
  #   self.user.username
  # end
end
