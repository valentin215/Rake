task 'third_task' => %w[first_task second_task] do
  puts 'third task'
end

task 'first_task' => %w[before_task] do
  puts 'first task'
end

task 'second_task' => %w[before_task] do
  puts 'second task'
end

task 'before_task' do
  puts 'before'
end
