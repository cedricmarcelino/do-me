class TasksController < ApplicationController
  before_action :set_task, :set_category, :set_user, :authenticate_user!, only: [:show, :update, :destroy]
  before_action :set_category, :set_user, :authenticate_user!, only: [:index,:create,:show,:update]

  # GET /tasks
  def index
    if @user.categories.exists?(id: @category.id)
      @tasks = @category.tasks
      render :index
    else
      redirect_to categories_path
    end
  end

  # GET /tasks/1
  def show
    if @user.categories.exists?(id: @category.id) && @category.tasks.exists?(id: @task.id) ##&& task_under_user? 
      render :show
    else
      redirect_to user_categories_path(current_user.id)
    end
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.category_id = @category.id
    @task.user_id = current_user.id
    @task.save
    redirect_to user_category_tasks_path(user_id: current_user.id, category_id: @category.id)
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to user_category_tasks_path(user_id: current_user.id, category_id: @category.id)
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to user_category_tasks_path(user_id: current_user.id, category_id: params[:category_id])
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
      params.require(:task).permit(:name, :description, :user_id, :category_id, :due_date, :is_done)
    end
end
