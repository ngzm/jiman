json.array!(@users) do |user|
  json.extract! user, :id, :name, :full_name, :image, :admin, :created_at, :updated_at
end
