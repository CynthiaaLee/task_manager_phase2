class Label < ApplicationRecord
    has_many :task_labels, dependent: :destroy
    has_many :tasks, through: :task_labels
  
    LABEL_OPTIONS = ["Urgent", "High Priority", "Medium Priority", "Low Priority", "Work", "Personal", "School"].freeze
  end
  