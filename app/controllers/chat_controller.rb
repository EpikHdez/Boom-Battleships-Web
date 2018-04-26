class ChatController < ApplicationController
  def index
    user_friendships = @current_user.friendships
                                    .joins(:messages)
                                    .group('friendships.id')
    inverse_friendships = Friendship.joins(:messages)
                                    .where("friend_id = #{@current_user.id}")
                                    .group('friendships.id')
    @friendships = Array.new
    
    user_friendships.each do |fs|
      @friendships.push(fs)
    end

    inverse_friendships.each do |inv_fs|
      friendship = Friendship.where("user_id = #{inv_fs.friend_id} AND friend_id = #{inv_fs.user_id}").first
      @friendships.push(friendship)
    end

    @friendships = @friendships.uniq

    respond_to :json
  end
end
