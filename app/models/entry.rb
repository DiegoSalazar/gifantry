# == Schema Information
#
# Table name: entries
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  image_file_name    :string(255)
#  image_file_size    :integer
#  image_content_type :string(255)
#  album_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Entry < ActiveRecord::Base
  belongs_to :album, counter_cache: true
  
  has_attached_file :image
  validates_attachment_content_type :image, content_type: [
    "image/jpeg", "image/pjpeg", "image/jpg", "image/png", "image/gif"
  ]

  scope :sorted, -> { order "created_at DESC" }
end
