# Frozen_string_literal: true

# Description: A simple rake clone

TASKS = {}

# TASKS should look like this:
#
# {"third_task"=>
#   #<Task:0x00007fc9268d30c8
#    @action=
#     #<Proc:0x00007fc9268d30f0>,
#    @deps=["first_task", "second_task"],
#    @name="third_task">,
#  "first_task"=>
#   #<Task:0x00007fc9268d2f88
#    @action=
#     #<Proc:0x00007fc9268d3000>,
#    @deps=["before_task"],
#    @name="first_task">,
#  "second_task"=>
#   #<Task:0x00007fc9268d2e98
#    @action=
#     #<Proc:0x00007fc9268d2ec0>,
#    @deps=["before_task"],
#    @name="second_task">,
#  "before_task"=>
#   #<Task:0x00007fc9268d2df8
#    @action=
#     #<Proc:0x00007fc9268d2e20>,
#    @deps=[],
#    @name="before_task">}

# Task class
class Task
  def initialize(name, deps, action)
    @name = name
    @deps = deps
    @action = action
  end

  def invoke
    return if @already_run

    @deps.each { |dep| TASKS[dep].invoke }
    execute
    @already_run = true
  end

  def execute = @action.call
end

def task(name, &block)
  name, deps = name.is_a?(String) ? [name, []] : name.first

  TASKS[name] = Task.new(name, deps, block)
end

load './Rakefile'

ARGV.each { |arg| TASKS[arg].invoke }
