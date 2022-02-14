class TasksController < ApplicationController
  before_action :set_task, :set_category, :set_user only:, :authenticate_user! [:show, :edit, :update, :destroy]
  before_action :set_category, :set_user only:, :authenticate_user! [:index]

  # GET /tasks
  def index
    if user_authorized? && category_under_user?
      render :index
    else
      redirect_to user_categories_path(current_user.id)
    end
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def user_authorized?
      if current_user.id == @user.id
        true
      else
        false
      end
    end

    def category_under_user?
      if @category.user_id == current_user.id
        true
      else
        false
      end
    end

    def task_under_user?
      if @task.user_id == current_user.id
        true
      else
        false
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :user_id_id, :category_id, :due_date, :is_done)
    end
end
