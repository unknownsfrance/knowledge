json.array!(@langs) do |lang|
  json.id lang.id
  json.label lang.name 
  json.value lang.name
end
