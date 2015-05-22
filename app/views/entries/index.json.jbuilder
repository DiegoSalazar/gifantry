json.array!(@entries) do |entry|
  json.extract! entry, :id, :name, :description, :image_file_name, :image_file_size, :image_content_type, :album_id
  json.url entry_url(entry, format: :json)
end
