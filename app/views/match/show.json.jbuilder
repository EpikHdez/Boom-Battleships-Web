json.id @match.id
json.score @match.score
json.destroyed_ships @match.destroyed_ships
json.lost_ships @match.lost_ships
json.turn @match.turn
json.board_set @match.board_set
json.victory @match.victory
json.finished @match.finished
json.game_number @match.game_number
json.board @board

json.rival do
  json.id @match.rival.id
  json.name @match.rival.name
  json.picture @match.rival.picture
end