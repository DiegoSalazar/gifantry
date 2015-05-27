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

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
