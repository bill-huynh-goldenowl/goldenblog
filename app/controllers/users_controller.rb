class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit_password, :update, :update_pwd,:destroy]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    render :show
  end

  def edit
    @user = current_user
    render :edit
  end
  
  def edit_password
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Update profile successful!"
      redirect_to root_path
    else
      flash[:error] = "Update profile failure!"
      render :edit
    end
  end

  def update_pwd
    @user.update(password: params[:password])
    redirect_to users_index_path
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :fullname, :location)
  end
end