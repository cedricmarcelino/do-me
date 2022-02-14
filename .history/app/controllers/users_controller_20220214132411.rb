class UsersController < ApplicationController
  before_action :set_user, :authenticate_user!, only: [ :show, :edit, :update, :destroy]
  before_action :user_authorized?, only: [:show]

  # GET /users/1
  def show
    if user_authorized?
      render :show
    else
      redirect_to @user
    end
  end

  # GET /users/1/edit
  def edit

  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
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
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end

    def user_authorized?
      if current_user.id == @user.id
        true
      else
        false
      end
    end
end
