json.array!(@tags) do |tag|
  json.id tag.id
  json.label tag.tag 
  json.value tag.tag
end
