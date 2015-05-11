json.array!(@ideas) do |idea|
  json.extract! idea, :id, :name, :description, :files, :user_id
  json.url idea_url(idea, format: :json)
end
