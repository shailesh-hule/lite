
require "date"

class Todo

  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @completed = completed
    # @overdue =  Date.today < due_date ? true : false
    # @due_today = Date.today == due_date ? true : false
    # @due_later =  Date.today > due_date ? true : false
  end

  def overdue
    Date.today > @due_date ? true : false
  end

  def due_today
    Date.today == @due_date ? true : false
  end

  def due_later
    Date.today < @due_date ? true : false
  end

  def to_displayable_string
    x = @completed?"X":""
    return "[#{x}] #{@text} #{@due_date}"
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later })
  end

  def to_displayable_list
    text_todos = []
    @todos.each do |i|
      text_todos.append(i.to_displayable_string())
    end
    text_todos = text_todos.join("\n")
    return text_todos
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

#todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"