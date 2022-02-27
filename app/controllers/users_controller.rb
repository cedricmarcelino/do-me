class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show, :edit, :update, :destroy]
  
  def update
    if current_user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name)
    end
    
end
