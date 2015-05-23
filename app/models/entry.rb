class Entry < ActiveRecord::Base
  belongs_to :album
  
  has_attached_file :image
  validates_attachment_content_type :image, content_type: [
    "image/jpeg", "image/pjpeg", "image/jpg", "image/png", "image/gif"
  ]
end
