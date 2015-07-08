require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_it_can_grab_all_tasks
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})
    tasks = TaskManager.all
    assert_equal 2, tasks.count
    assert_equal 1, tasks.first.id
    assert_equal "2 title", tasks[1].title
  end

  def test_it_can_find_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})
    assert_equal "a title", TaskManager.find(1).title
    assert_equal "2 description", TaskManager.find(2).description
  end

  def test_it_can_update_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})

    TaskManager.update(1, {:title => "title", :description => "description"} )

    assert_equal "title", TaskManager.find(1).title

  end

  def test_it_can_delete
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})
    TaskManager.delete(2)

    assert_equal 1, TaskManager.all.count
    assert_equal 0, TaskManager.delete_all
  end

end