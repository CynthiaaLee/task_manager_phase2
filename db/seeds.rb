# Reset the database: Delete all existing records
puts "🗑️ Deleting all existing data..."
User.destroy_all
Task.destroy_all
Comment.destroy_all
Label.destroy_all
TaskLabel.destroy_all

# Reset primary keys (PostgreSQL only)
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('tasks')
ActiveRecord::Base.connection.reset_pk_sequence!('comments')
ActiveRecord::Base.connection.reset_pk_sequence!('labels')
ActiveRecord::Base.connection.reset_pk_sequence!('task_labels')

puts "✅ Database reset completed!"

# Create Users
puts "👤 Creating users..."
user1 = User.create!(name: "Alice", email: "alice@example.com", password: "password")
user2 = User.create!(name: "Bob", email: "bob@example.com", password: "password")
user3 = User.create!(name: "Cassy", email: "cassy@example.com", password: "password")

puts "✅ Users created!"

# Create Labels
puts "🏷️ Creating predefined labels..."
Label::LABEL_OPTIONS.each do |label_name|
  Label.create!(name: label_name)
end

puts "✅ Labels created!"

# Create Tasks
puts "📝 Creating tasks..."
task1 = Task.create!(title: "Prepare for Meeting", description: "Review notes for the team meeting", status: "Not Started", due_date: Date.today + 2, user: user1)
task2 = Task.create!(title: "Submit Project", description: "Upload the final project files", status: "Completed", due_date: Date.today - 1, user: user2)
task3 = Task.create!(title: "Complete Phase 1", description: "Finish all Phase 1 requirements", status: "In Progress", due_date: Date.today + 5, user: user3)

puts "✅ Tasks created!"

# Assign Labels to Tasks
puts "🔗 Assigning labels to tasks..."
task1.labels << Label.find_by(name: "Urgent")
task1.labels << Label.find_by(name: "Work")

task2.labels << Label.find_by(name: "High Priority")
task2.labels << Label.find_by(name: "School")

task3.labels << Label.find_by(name: "Personal")
task3.labels << Label.find_by(name: "Low Priority")

puts "✅ Labels assigned!"

# Create Comments
puts "💬 Adding comments to tasks..."
Comment.create!(content: "Don't forget the documentation!", task: task1, user: user1)
Comment.create!(content: "Meeting rescheduled to 3 PM.", task: task2, user: user2)
Comment.create!(content: "Project was successfully submitted!", task: task3, user: user3)

puts "✅ Comments added!"

puts "🎉 Database seeding completed successfully!"
