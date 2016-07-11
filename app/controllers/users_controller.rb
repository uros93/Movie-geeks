class UsersController < ApplicationController
   before_action :authenticate_user!
  before_action :set_user, except: :index
  
  before_action :check_ownership, only: [:edit, :update]
  respond_to :html, :js
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :about, :avatar, :cover)
        
  end

  def check_ownership
    redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
