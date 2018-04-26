json.matches @matches do |match|
  json.id match.id
  json.score match.score
  json.turn match.turn
  json.victory match.victory
  json.finished match.finished
  json.board_set match.board_set
  json.game_number match.game_number

  json.rival do
    json.id match.rival.id
    json.name match.rival.name
    json.picture match.rival.picture
  end
end