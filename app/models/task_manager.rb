require 'yaml/store'
require 'sequel'
require 'sqlite3'

class TaskManager
  def self.create(task)
    # database.transaction do
    #   database['tasks'] ||= []
      # database['total'] ||= 0
      # database['total'] += 1
    # database['tasks'] << { "id" => database['total'],
    #                        "title" => task[:title], "description" => task[:description] }
  # end
    begin
    dataset.insert(:title => task[:title], :description => task[:description])
    rescue
      false
    end
    Task.new(dataset.to_a.last)
  end

  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      # @database ||= YAML::Store.new("db/task_manager_test")
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager_development.sqlite3")
      # @database ||= YAML::Store.new("db/task_manager")
    end
  end

  # def self.raw_tasks
  #   database.transaction do
  #   database['tasks'] || []
  #   end
  # end

  def self.all
    dataset.to_a.map { |data| Task.new(data)}
    # raw_tasks.map { |data| Task.new(data) }
  end

  def self.dataset
    database.from(:tasks)
  end

  # def self.raw_task(id)
  #   raw_tasks.find { |task| task["id"] == id }
  # end

  def self.find(id)
    Task.new(dataset.where(id: id).first)
    # Task.new(raw_task(id))
  end

  def self.update(id, task)
    # database.transaction do
    #   target = database['tasks'].find { |data| data["id"] == id }
    #   target["title"] = task[:title]
    #   target["description"] = task[:description]
    # end
    dataset.where(id: id).update(title: task[:title], description: task[:description])
  end

  def self.delete(id)
    # database.transaction do
      # database["tasks"].delete_if {|task| task["id"] == id}
      dataset.where(id: id).delete
    # end
  end

  def self.delete_all
    dataset.delete
    # database.transaction do
    #   database["tasks"] = []
    #   database["total"] = 0
    # end
  end
end