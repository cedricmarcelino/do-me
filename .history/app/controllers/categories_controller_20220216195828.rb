class CategoriesController < ApplicationController
  before_action :set_category, :authenticate_user!, only: [ :show, :update, :destroy]
  before_action :set_user,  :authenticate_user!, only: [:index, :new, :show, :update]
  # before_action :user_authorized?, only: [:index]

  # GET /categories
  def index
    @categories = Category.where(user_id: @user.id)
    render :index
  end

  # GET /categories/new
  def new
    render :new
  end

  def show
    if category_under_user?
      render :show
    else
      redirect_to user_categories_path(current_user.id)
    end
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id

    if @category.save
      redirect_to user_categories_path(user_id: current_user.id)
    else
      render :new
    end


  end

  # PATCH/PUT /categories/1
  def update

    if user_authorized? && category_under_user? && @category.update(category_params)
      redirect_to user_category_tasks_path(user_id: current_user.id, category_id: @category.id)
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def category_under_user?
      if @category.user_id == current_user.id
        true
      else
        false
      end
    end
    
    def set_user
      @user = User.find(current_user.id)
    end
    
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :user_id)
    end
end
