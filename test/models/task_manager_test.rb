require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    task = TaskManager.find(TaskManager.all.first.id)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal TaskManager.all.first.id, task.id
  end

  def test_it_can_grab_all_tasks
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})
    tasks = TaskManager.all
    assert_equal 2, tasks.count
    assert_equal "2 title", tasks[1].title
  end

  def test_it_can_find_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})
    assert_equal "a title", TaskManager.find(TaskManager.all[0].id).title
    # assert_equal "2 description", TaskManager.find(TaskManager.all[2].description)
  end

  def test_it_can_update_a_task
    task = TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})

    TaskManager.update(task.id, {:title => "title", :description => "description"} )

    assert_equal "title", TaskManager.find(task.id).title

  end

  def test_it_can_delete
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "2 title",
                         :description => "2 description"})


    TaskManager.delete(TaskManager.all.last.id)
    assert_equal 1, TaskManager.all.count
    TaskManager.delete_all
    assert_equal 0, TaskManager.all.size
  end

end