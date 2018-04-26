class UsersController < ApplicationController
  def index
    user_friends = @current_user.friends

    @users = User.find_by_sql("SELECT U.*
                              FROM users U
                              WHERE U.id NOT IN (SELECT FS.friend_id
                                          FROM friendships FS
                                          WHERE FS.user_id = #{@current_user.id})
                                AND U.id <> #{@current_user.id}
                                AND U.user_type_id <> 1")
  end

  def random
    @user = nil
    users_quantity = User.all.count

    while @user.nil?
      id = rand(1..users_quantity)
      @user = User.find(id)
      @user = nil if @user.id == @current_user.id || @user.user_type.id == 1
    end

    respond_to :json
  end
end
