json.extract! @jiman,   \
              :id, :title, :description, :url, :image, \
              :point1, :point2, :point3, :point4, \
              :access, :star, :created_at, :updated_at

json.user do
  json.extract! @jiman.user, :id, :name, :full_name, :email, :image, :admin
end

json.categories do
  json.array!(@jiman.categories) do |ctg|
    json.id(ctg.id)
    json.name(ctg.name)
  end
end

reviews = (@jiman.reviews.sort_by &:updated_at).reverse
json.reviews do
  json.array!(reviews.slice(0, 6)) do |rvw|
    json.id(rvw.id)
    json.comment(rvw.comment)
    json.star(rvw.star)
    json.user_id(rvw.user_id)
    json.user_name(rvw.user.name)
  end
end
