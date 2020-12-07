class Task
  attr_accessor :id, :title, :completed, :created_at

  def initialize(id, title)
    @id = id
    @title = title
    @completed = false
    @created_at = (Time.now.to_f * 1000).to_i # timestamp in milliseconds
  end
end
