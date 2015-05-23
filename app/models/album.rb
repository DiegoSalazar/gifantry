class Album < ActiveRecord::Base
  belongs_to :user
  has_many :entries

  before_validation :make_slug
  validates :name, :slug, presence: true, uniqueness: true

  default_scope { order :sort }

  private

  def make_slug
    self.slug ||= name.parameterize if name
  end
end
