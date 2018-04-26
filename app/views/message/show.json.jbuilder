json.conversation do
  json.messages @messages do |message|
    json.user message.friendship.user.id
    json.text message.text
    json.date message.created_at
  end
end