$tasks_storage = []

class TasksController < ApplicationController
  # GET '/tasks'
  # GET '/tasks/active'
  # GET '/tasks/completed'
  def index
    active = $tasks_storage.select { |t| t.completed == false }
    completed = $tasks_storage.select { |t| t.completed == true }

    case params['filter']
    when 'active'
      @filter = params['filter']
      # created at descending
      @tasks = active
    when "completed"
      @filter = params['filter']
      # created at descending
      @tasks = completed
    else
      @tasks = $tasks_storage
    end

    @tasks = @tasks.sort_by{ |t| t.created_at }

    @activeCount = active.count
    @completedCount = completed.count
    @allCompleted = @tasks.count > 0 && @activeCount == 0
  end

  # POST '/'
  def create
    params.require(:task).permit(:task)
    @task = Task.new($tasks_storage.length, params[:task][:title])
    $tasks_storage.push(@task)
    redirect_back(fallback_location: 'tasks')
  end

  # PUT '/tasks/:id'
  def update
    params.require(:task).permit(:title, :completed, :id)
    id = params[:id].to_i
    @task = $tasks_storage.find { |t| t.id == id }
    if params[:task][:title]
      @task.title = params[:task][:title]
      $tasks_storage.delete_if { |t| t.id == id }
      $tasks_storage.push(@task)
    end
    if params[:task][:completed]
      completed = params[:task][:completed].to_s == "true" # convert param to bool
      @task.completed = completed
      $tasks_storage.delete_if { |t| t.id == id }
      $tasks_storage.push(@task)
    end
    redirect_back(fallback_location: 'tasks')
  end

  # DELETE '/tasks/:id'
  def destroy
    id = params[:id].to_i
    $tasks_storage.delete_if { |t| t.id == id }
    redirect_back(fallback_location: 'tasks')
  end

  # POST '/tasks/clear_completed'
  def clear_completed
    $tasks_storage.delete_if { |t| t.completed == true }
    redirect_back(fallback_location: 'tasks')
  end
end
