$tasks_array = []

class TasksController < ApplicationController
  # GET '/tasks'
  # GET '/tasks/active'
  # GET '/tasks/completed'
  def index
    active = $tasks_array.select { |task| task.completed == false }
    completed = @tasks = $tasks_array.select { |task| task.completed == true }

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
      @tasks = $tasks_array
    end

    @activeCount = active.count
    @completedCount = completed.count
    @allCompleted = @tasks.count > 0 && @activeCount == 0
  end

  # POST '/'
  def create
    params.require(:task).permit(:task)
    @task = Task.new($tasks_array.length, params[:task][:title])
    $tasks_array.push(@task)
    redirect_back(fallback_location: 'tasks')
  end

  # PUT '/tasks/:id'
  def update
    params.require(:task).permit(:title, :completed, :id)
    id = params[:id].to_i
    @task = $tasks_array.find { |t| t.id == id }
    if params[:task][:title]
      @task.title = params[:task][:title]
      $tasks_array.delete_if { |t| t.id == id }
      $tasks_array.push(@task)
    end
    if params[:task][:completed]
      @task.completed = params[:task][:completed]
      $tasks_array.delete_if { |t| t.id == id }
      $tasks_array.push(@task)
    end
    redirect_back(fallback_location: 'tasks')
  end

  # DELETE '/tasks/:id'
  def destroy
    id = params[:id].to_i
    $tasks_array.delete_if { |t| t.id == id }
    redirect_back(fallback_location: 'tasks')
  end

  # POST '/tasks/toggle_complete_all'
  def toggle_complete_all
    if params['complete-all']
      for i in $tasks_array.length
        $tasks_array[i].completed = true
      end
    else
      for i in $tasks_array.length
        $tasks_array[i].completed = false
      end
    end
    redirect_back(fallback_location: 'tasks')
  end

  # POST '/tasks/clear_completed'
  def clear_completed
    $tasks_array.delete_if { |t| t.completed == true }
    redirect_back(fallback_location: 'tasks')
  end

  private
  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
