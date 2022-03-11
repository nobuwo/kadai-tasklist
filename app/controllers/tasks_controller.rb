class TasksController < ApplicationController
  before_action :require_logged_in
  before_action :correct_user, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    #if logged_in?
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
    #end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html {redirect_to task_url(@task), notice: "Task が正常に投稿されました"}
      else
        flash.now[:danger] = 'Task が投稿されませんでした'
        format.html {render :new}
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to task_url(@task), notice: "Task が正常に更新されました."}
      else
        flash.now[:danger] = 'Task が更新されませんでした'
        format.html {render :edit}
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html {redirect_to tasks_url, notice: "Task は正常に削除されました"}
    end
  end

  private
  
  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
