json.chats @friendships do |friendship|
  json.id friendship.id

  json.friend do
    json.id friendship.friend.id
    json.name friendship.friend.name
    json.picture friendship.friend.picture
  end
end