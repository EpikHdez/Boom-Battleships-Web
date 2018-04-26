# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserType.create([{name: 'Administrator'}, {name: 'Player'}])
admin_type = UserType.find(1)
player_type = UserType.find(2)

User.create(name: 'Admin', email: 'admin@admin.com', password: 'Admin', user_type: admin_type)
User.create(name: 'Erick', email: 'e@a.com', password: '123Queso', user_type: player_type)
User.create(name: 'Ximena', email: 'x@b.com', password: '123Queso', user_type: player_type)
User.create(name: 'Ariana', email: 'a@b.com', password: '123Queso', user_type: player_type)
User.create(name: 'Luis', email: 'l@c.com', password: '123Queso', user_type: player_type)

Friendship.create(user_id: 2, friend_id: 3)
Friendship.create(user_id: 2, friend_id: 5)
Friendship.create(user_id: 3, friend_id: 4)
Friendship.create(user_id: 3, friend_id: 5)
Friendship.create(user_id: 4, friend_id: 5)