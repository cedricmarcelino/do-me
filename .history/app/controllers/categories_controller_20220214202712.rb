class CategoriesController < ApplicationController
  before_action :set_category, :authenticate_user!, only: [ :show, :edit, :update, :destroy]
  before_action :set_user,  :authenticate_user!, only: [:index, :new, :show, :edit]
  # before_action :user_authorized?, only: [:index]

  # GET /categories
  def index
    @categories = Category.where(user_id: current_user.id)
    if user_authorized?
      render :index
    else
      redirect_to user_categories_path(current_user.id)
    end
  end

  # GET /categories/1
  def show
    if user_authorized? && category_under_user?
      render :show
    else
      redirect_to user_categories_path(current_user.id)
    end
  end

  # GET /categories/new
  def new
    if user_authorized?
      render :new
    else
      redirect_to new_user_category_path(current_user.id)
    end
  end

  # GET /categories/1/edit
  def edit
    if user_authorized? && category_under_user?
      render :edit
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
    if user_authorized? && category_under_user?
      render :show
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
      @user = User.find(params[:user_id])
    end
    
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :user_id)
    end

    def user_authorized?
      if current_user.id == @user.id
        true
      else
        false
      end
    end
end
