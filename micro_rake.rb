# Frozen_string_literal: true

# Description: A simple rake clone

TASKS = {}

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
