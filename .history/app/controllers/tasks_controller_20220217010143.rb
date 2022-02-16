class TasksController < ApplicationController
  before_action :set_task, :set_category, :set_user, :authenticate_user!, only: [:show, :update, :destroy]
  before_action :set_category, :set_user, :authenticate_user!, only: [:index,:create,:show,:update,:due]

  # GET /tasks
  def index
    if @user.categories.exists?(id: @category.id)
      @tasks = @category.tasks
      render :index
    else
      redirect_to categories_path
    end
  end

  def due 
    @tasks = null
  end

  # GET /tasks/1
  def show
    if @user.categories.exists?(id: @category.id) && @category.tasks.exists?(id: @task.id)
      render :show  
    else
      redirect_to categories_path
    end
  end

  # POST /tasks
  def create
    @task = @category.tasks.build(task_params)
    @task.save
    redirect_to category_tasks_path(category_id: @category.id)
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to category_tasks_path(category_id: @category.id)
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to category_tasks_path(category_id: @task.category_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_user
      @user = User.find(current_user.id)
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :due_date, :is_done, :category_id)
    end
end
