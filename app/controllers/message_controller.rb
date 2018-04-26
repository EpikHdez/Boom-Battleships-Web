class MessageController < ApplicationController
  def show
    friendship1 = @current_user.friendships.find(params[:friendship_id])
    friendship2 = Friendship.find_by(user_id: friendship1.friend_id, friend_id: friendship1.user_id)

    @messages = Message.all.joins(:friendship)
                           .where("messages.friendship_id = #{friendship1.id} OR \
                                   messages.friendship_id =  #{friendship2.id}")
                           .order("messages.created_at")

    respond_to do |format|
      format.json
    end
  end

  def create
    info = message_params
    @friendship = @current_user.friendships.find(info[:friendship_id])
    @message = @friendship.messages.create!(info)
    
    response.status = :created
    respond_to do |format|
        format.json
    end
  end

  private

  def message_params
    params.require(:message).permit(:friendship_id, :text)
  end
end
