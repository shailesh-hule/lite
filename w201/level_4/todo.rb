require "date"
require 'active_record'

class Todo < ActiveRecord::Base
    def due_today?
        due_date == Date.today
    end
    
    def to_displayable_string
        display_status = completed ? "[x]" : "[ ]"
        display_date = due_today? ? nil : due_date
        display_id = id
        "#{display_id} #{display_status} #{todo_text} #{display_date}"
    end

    def self.to_displayable_list
        all.map {|todo| todo.to_displayable_string }
    end

    def overdue
        Date.today > due_date
    end

    def due_today
        Date.today == due_date
    end

    def due_later
        Date.today < @due_date 
    end

    def self.show_non_completed_tasks
        puts all.where(complete: false).to_displayable_list
    end    
    
    def self.show_list
        puts "My Todo-list\n\n"
        puts "Overdue"
        puts all.where(due_date: ...Date.today).to_displayable_list
        puts "\n\n"

        puts "Due Today"
        puts all.where(due_date: Date.today).to_displayable_list
        puts "\n\n"

        puts "Due Later"
        puts all.where(due_date: Date.today...).to_displayable_list
    end    

    def self.add_task(task_details)
        self.create!(todo_text: task_details[:todo_text], due_date: Date.today + task_details[:due_in_days], completed: false)     
    end 
    
    def self.mark_as_complete(task_id)
        self.update(task_id,completed: true)
    end    
end