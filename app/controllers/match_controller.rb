class MatchController < ApplicationController
  def index
    @matches = @current_user.matches

    respond_to do |format|
      format.json
    end
  end

  def show
    @match = @current_user.matches.find(params[:match_id])
    inverse_match = @match.rival.matches.find_by(game_number: @match.game_number)
    @board = inverse_match.board

    respond_to do |format|
      format.json
    end
  end

  def create
    rival = create_params
    err_msg = 'User and rival cannot be the same person.'
    rival_id = Integer(rival[:rival_id])

    return json_response({error: err_msg}, :unprocessable_entity) unless @current_user.id != rival_id
    matches = Match.all.group(:game_number).count

    if matches.empty?
      game_number = 1
    else
      game_number = matches.count + 1
    end
    puts game_number

    info = {rival_id: rival[:rival_id], game_number: game_number}
    @match = @current_user.matches.create!(info)

    response.status = :created
    respond_to do |format|
      format.json
    end
  end

  def setup
    match = @current_user.matches.find(params[:match_id])
    return json_response({error: 'Board already set.'}, :unprocessable_entity) if match.board_set?
    
    info = setup_params
    inverse_info = {turn: true}
    inverse_match = match.rival.matches.find_by(game_number: match.game_number)

    match.update!(info)
    inverse_match.update!(inverse_info)
    head :no_content
  end

  def update
    match_info = update_params

    if match_info.key?(:finished)
      if match_info.key?(:victory)
        inverse_victory = !match_info[:victory]
        inverse_info = {lost_ships: match_info[:destroyed_ships], board: match_info[:board], turn: false, victory: inverse_victory, finished: true}
      else
        return json_response({error: 'Missing victory param.'}, :unprocessable_entity)
      end
    else
      inverse_info = {lost_ships: match_info[:destroyed_ships], turn: true, board: match_info[:board]}
    end

    match_info.delete(:board)

    @match = @current_user.matches.find(params[:match_id])
    inverse_match = @match.rival.matches.find_by(game_number: @match.game_number)

    json_response({error: 'Cannot update a finished game.'}, :unprocessable_entity) if @match.finished

    @match.update!(match_info)
    inverse_match.update!(inverse_info)
    
    respond_to :json
  end

  private

  def create_params
    params.require(:match).permit(:rival_id)
  end

  def update_params
    info = params.require(:match).permit(:score, :destroyed_ships, :victory, :finished, :board)
    info[:turn] = false

    info
  end

  def setup_params
    info = params.require(:match).permit(:board)
    info[:board_set] = true
    info[:turn] = false
    
    info
  end
end
