require_relative '../test_helper'

class UserSeesAllTasksTest < FeatureTest
  def test_user_sees_index_of_tasks
    visit('/tasks')
    assert page.has_css?('#task-title')
  end

  def test_front_page_has_greeting_with_message
    visit("/")
    within ("#greeting") do
     assert page.has_content?("Welcome to the Task Manager")
    end
  end

  def test_home_page_displays_welcome_message
   visit("/")
   assert page.has_content?("Welcome to the Task Manager")
  end

  def test_submission_of_new_task_form
    visit('/')
    click_link("New Task")
    assert_equal "/tasks/new", current_path

    fill_in('task[title]', with: "Pizza")
    fill_in('task[description]', with: "Eat it")
    click_button('Create Task')

    assert_equal "/tasks", current_path

    visit ("/tasks")
    within (".container") do
    assert page.has_content?("Pizza")
    end
  end

  def test_deleting_a_task
    visit('/')
    click_link("New Task")
    assert_equal "/tasks/new", current_path

    fill_in('task[title]', with: "Pizza")
    fill_in('task[description]', with: "Eat it")
    click_button('Create Task')

    assert_equal "/tasks", current_path

    visit ("/tasks")
    click_button("delete")

    refute page.has_content?("Pizza")
  end

  def test_editing_a_task
    visit('/')
    click_link("New Task")
    assert_equal "/tasks/new", current_path

    fill_in('task[title]', with: "Pizza")
    fill_in('task[description]', with: "Eat it")
    click_button('Create Task')

    assert_equal "/tasks", current_path

    visit ("/tasks")
    click_link("Edit")


    fill_in('task[title]', with: "Ragu")
    fill_in('task[description]', with: "Make it")
    click_button("Update Task")

    assert page.has_content?("Ragu")

  end

end