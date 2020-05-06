json.extract! @jiman,   \
              :id, :title, :description, :url, :image, \
              :access, :star, :created_at, :updated_at

json.categories do
  json.array!(@categories) do |ctg|
    json.id(ctg.id)
    json.name(ctg.name)
  end
end
