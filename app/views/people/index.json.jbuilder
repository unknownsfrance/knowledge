json.array!(@people) do |person|
  json.extract! person, :id, :name, :url, :description, :nb_people, :adresse, :contact_name, :files, :tags, :expertises, :category
  json.url person_url(person, format: :json)
end
