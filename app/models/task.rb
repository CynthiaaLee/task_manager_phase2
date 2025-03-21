class Task < ApplicationRecord
    belongs_to :user  # 👈 Ensure this line exists
    has_many :comments, dependent: :destroy
    has_many :task_labels, dependent: :destroy
    has_many :labels, through: :task_labels
    validates :title, presence: true
    validates :status, inclusion: { in: ["Not Started", "In Progress", "Completed"] }
  end
