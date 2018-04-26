json.id @current_user.id
json.name @current_user.name
json.email @current_user.email
json.money @current_user.money
json.picture @current_user.picture

json.type do
    json.id @current_user.user_type.id
    json.name @current_user.user_type.name
end