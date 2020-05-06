json.array!(@reviews) do |review|
  json.id(review.id)
  json.star(review.star)
  json.comment(review.comment)
  json.jiman_id(review.jiman_id)
  json.user_id(review.user_id)
  json.user_name(review.user.name)
  json.created_at(review.created_at)
  json.updated_at(review.updated_at)
end
