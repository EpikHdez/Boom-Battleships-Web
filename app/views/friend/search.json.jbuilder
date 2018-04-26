json.friendshipships @friendships do |friendship|
  json.id friendship.id

  json.friend do
    json.id friendship.friend_id
    json.name friendship.name
    json.picture friendship.picture
  end
end
