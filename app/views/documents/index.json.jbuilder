json.array!(@documents) do |document|
  json.extract! document, :id, :location, :title, :description, :tags, :user_id
  json.url document_url(document, format: :json)
end
