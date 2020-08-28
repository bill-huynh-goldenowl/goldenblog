class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    render "edit"
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Update successful!"
      redirect_to users_edit_path
    else
      flash[:error] = "Update failure!"
      render users_edit_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end