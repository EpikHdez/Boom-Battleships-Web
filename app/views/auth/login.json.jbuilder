json.auth_token @command.result
json.user do
  json.id @user.id
  json.name @user.name
  json.email @user.email
  json.picture @user.picture
  json.money @user.money
  json.user_type do
    json.id @user.user_type.id
    json.name @user.user_type.name
  end
end