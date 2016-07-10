class FollowsController < ApplicationController
   before_action :authenticate_user!
  respond_to :js,:html

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to users_index_path
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    redirect_to users_index_path
  end
end
