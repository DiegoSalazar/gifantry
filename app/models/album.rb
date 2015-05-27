# == Schema Information
#
# Table name: albums
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  slug          :string
#  sort          :integer          default(0)
#  entries_count :integer
#

class Album < ActiveRecord::Base
  belongs_to :user
  has_many :entries

  before_validation :make_slug
  validates :name, :slug, presence: true, uniqueness: true

  default_scope { order "LOWER(name)" }

  private

  def make_slug
    self.slug ||= name.parameterize if name
  end
end
