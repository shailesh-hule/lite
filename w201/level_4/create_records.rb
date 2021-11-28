require './connect_db.rb'
require './todo.rb'
connect_db!
Todo.create!(todo_text: "Sharany's fee", due_date: Date.today - 4, completed: false)
Todo.create!(todo_text: "Paper submission", due_date: Date.today - 2, completed: true)
Todo.create!(todo_text: "Book Ticket", due_date: Date.today, completed: false)