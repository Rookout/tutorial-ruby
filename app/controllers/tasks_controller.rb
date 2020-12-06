class TasksController < ApplicationController
  # GET '/tasks'
  # GET '/tasks/active'
  # GET '/tasks/completed'
  def index
    case params['filter']
    when 'active'
      @filter = params['filter']
      @tasks = Task.where(:completed => false).order('tasks.created_at DESC')
    when "completed"
      @filter = params['filter']
      @tasks = Task.where(:completed => true).order('tasks.created_at DESC')
    else
      # @tasks = Task.all.order('tasks.created_at DESC')
      @tasks = []
    end

    # @activeCount = Task.where(:completed => false).count
    # @completedCount = Task.where(:completed => true).count
    # @allCompleted = @tasks.length > 0 && @activeCount == 0
    @activeCount = @tasks.count
    @completedCount = @tasks.count
    @allCompleted = @tasks.length > 0 && @activeCount == 0
  end

  # POST '/'
  def create
    @task = Task.new(task_params)
    @task.save
    redirect_back(fallback_location: 'tasks')
  end

  # PUT '/tasks/:id'
  def update
    @task = Task.find(params[:id])
    if params[:task][:title]
      @task.update_attribute(:title, params[:task][:title])
    end
    if params[:task][:completed]
      @task.update_attribute(:completed, params[:task][:completed])
    end
    redirect_back(fallback_location: 'tasks')
  end

  # DELETE '/tasks/:id'
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_back(fallback_location: 'tasks')
  end

  # POST '/tasks/toggle_complete_all'
  def toggle_complete_all
    if params['complete-all']
      Task.update_all(completed: true)
    else
      Task.update_all(completed: false)
    end
    redirect_back(fallback_location: 'tasks')
  end

  # POST '/tasks/clear_completed'
  def clear_completed
    Task.where(:completed => true).delete_all
    redirect_back(fallback_location: 'tasks')
  end

  private
  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
