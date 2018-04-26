json.users @top do |user|
  json.id user.id
  json.name user.name
  json.picture user.picture
  json.score user.score
  json.played_matches user.played_matches
end