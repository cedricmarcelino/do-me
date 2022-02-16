class UsersController < ApplicationController
  before_action :set_user, :authenticate_user!, only: [ :show, :edit, :update, :destroy]

  # GET /user
  def show
    render :show
  end

  # GET /user/edit
  def edit
    render :edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(current_user.id)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name)
    end
end
