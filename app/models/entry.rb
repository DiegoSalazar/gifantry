# == Schema Information
#
# Table name: entries
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text0
#  image_file_name    :string(255)
#  image_file_size    :integer
#  image_content_type :string(255)
#  album_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Entry < ActiveRecord::Base
  belongs_to :album, counter_cache: true
  scope :sorted, -> { order "entries.created_at DESC" }

  has_attached_file :image
  validates_attachment_content_type :image, content_type: [
    "image/jpeg", "image/pjpeg", "image/jpg", "image/png", "image/gif"
  ]
  acts_as_taggable

  include PgSearch
  pg_search_scope :search,
    against: {
      image_file_name: 'B',
      name: 'C',
      description: 'D'
    },
    associated_against: {
      tags: [:name],
      album: [:name]
    },
    using: {
      tsearch: {
        dictionary: "english",
        prefix: true,
        any_word: true
      }
    }
end
