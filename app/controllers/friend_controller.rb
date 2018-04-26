class FriendController < ApplicationController
  def index
    @friendships = @current_user.friendships

    respond_to do |format|
      format.json
    end
  end

  def show
    @friendship = @current_user.friendships.find_by(friend_id: params[:friend_id])
    
    respond_to do |format|
      format.json
    end
  end

  def search
    @friendships = @current_user.friends.joins(:friendships)
                            .where("name LIKE '%#{params[:friend_name]}%'")
                            .select("users.*, friendships.*")

    respond_to :json
  end

  def top
    @top = User.find_by_sql("SELECT U.*, 
                                    COUNT(M.*) AS played_matches,
                                    (CASE 
                                      WHEN COUNT(M.*) = 0 THEN 0
                                      ELSE SUM(M.score)
                                    END) AS score
                            FROM users U
                            INNER JOIN friendships FS
                              ON FS.friend_id = U.id
                            LEFT JOIN matches M
                              ON U.id = M.user_id
                            WHERE FS.user_id = #{@current_user.id} 
                              OR FS.friend_id = #{@current_user.id}
                            GROUP BY U.id
                            ORDER BY score DESC")

    respond_to :json
  end

  def create
    friend_info = friend_params
    friendship = @current_user.friendships.create(friend_info)

    json_response(friendship.errors, :unprocessable_entity) unless friendship.valid?

    @friend = @current_user.friends.find(params[:friend_id])

    response.status = :created
    respond_to do |format|
      format.json
    end
  end

  def destroy
    friendship1 = @current_user.friendships.find_by(friend_id: params[:friend_id])
    friend = friendship1.friend
    friendship2 = friend.friendships.find_by(friend_id: @current_user.id)

    friendship1.destroy
    friendship2.destroy

    head :no_content
  end

  private

  def friend_params
    params.require(:friend).permit(:friend_id)
  end
end
