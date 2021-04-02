class PhotoShout < ApplicationRecord
  has_attached_file :image, style: { thumb: "200x200" }
    # :default_url => "path to default image"


  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "image/jpg"] },
    size: { in: 0..10.megabytes },
    presence: true
end
