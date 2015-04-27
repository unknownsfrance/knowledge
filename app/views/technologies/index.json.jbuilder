json.array!(@technologies) do |technology|
  json.extract! technology, :id, :name, :url, :description, :tags, :files
  json.url technology_url(technology, format: :json)
end
