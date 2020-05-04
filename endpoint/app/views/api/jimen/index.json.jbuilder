json.array!(@jimen) do |jiman|
  json.extract! jiman, :id, :title, :description, :url, \
                :image, :access, :star, :created_at, :updated_at
end
