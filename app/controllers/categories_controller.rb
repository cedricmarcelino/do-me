class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [ :show, :update, :destroy]
  
  def index
    @categories = current_user.categories
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_tasks_path(category_id: @category.id)
    else
      render :show
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private

    def category_params
      params.require(:category).permit(:name, :description)
    end
end
