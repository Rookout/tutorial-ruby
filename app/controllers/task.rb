class Task
  attr_accessor :id, :title, :completed

  def initialize(id, title)
    @id = id
    @title = title
    @completed = false
  end
end
