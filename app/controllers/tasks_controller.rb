class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :index, :create, :update, :destroy, :set_task] 
  before_action :set_task, only: [:create, :update, :destroy, :show]

  def index
    @tasks = @category.tasks
  end

  def due 
    @due_tasks = current_user.tasks.where(is_done: false, due_date: Date.today)
  end

  def create
    @task = @category.tasks.build(task_params)
    @task.save
    redirect_to category_tasks_path(category_id: @category.id)
  end

  def update
    if @task.update(task_params)
      redirect_to category_tasks_path(category_id: @category.id)
    else
      render :show
    end
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(category_id: @task.category_id)
  end

  private
    def set_task
      @task = @category.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :due_date, :is_done, :category_id)
    end
end
