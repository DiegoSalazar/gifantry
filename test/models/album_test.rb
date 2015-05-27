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

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
