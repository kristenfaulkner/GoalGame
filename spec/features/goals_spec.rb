require 'spec_helper'

######## Create a New Goal ############
feature "Create a New Goal" do
  
  scenario "Goal has inputs for title and body" do
    sign_up("kirsten", "kirsten")
    visit new_goal_url
    expect(page).to have_content "Title"
    expect(page).to have_content "Body"
  end
  
  scenario "Goal title cannot be empty" do
    create_goal("", "This is a body")
    expect(page).to have_content "Title can't be empty"
    expect(current_path).to eq new_goal_path
  end
  
  scenario "Goal body cannot be empty" do
    create_goal("First Goal", "")
    expect(page).to have_content "Body can't be empty"
    expect(current_path).to eq new_goal_path    
  end  
  
  scenario "Goal should have Create button" do
    expect(page).to have_button "Create Goal"
  end
  
  scenario "Goal should be added to goals list after creation" do
    goal = create_goal("Learn Ruby", "App academy projects")
    expect(goal.id).to eq Goal.last.id
    expect(Goal.last.title).to eq "Learn Ruby"
    expect(Goal.last.body).to eq "App academy projects"
  end
  
  scenario "Goal should return to new goal page on creation failure" do
    current_path.should =~ goal_path + "/" + "/\d/"
  end
  
  scenario "Goal should redirect to goals index page on successful creation" do
    create_goal("Learn Ruby", "App academy projects")
    expect(current_path).to eq goals_path
    expect(page).to have_content "Learn Ruby"
    expect(page).to have_content "App academy projects"
  end
  
  scenario "Goal should have entries pre-filled on failed attempt" do
    create_goal("", "This has an empty title")
    find_field('Title').value.should eq ''
    find_field('Body').value.should eq 'This has an empty title'
  end
  
  scenario "After second attempt, still allows for successful creation" do
    create_goal("", "This has an empty title")
    fill_in "Title", with: "Our second try"
    click_button "Create Goal"
    expect(Goal.last.title).to eq "Our second try"
  end
  
  scenario "Goal user_id corresponds to current signed in user" do
    goal = create_goal("Pass assessment exam", "Pass all the exams")
    expect(goal.user_id).to eq User.last.id  
  end
  
  # scenario "Goal is added to user's list of goals" do
  #
  # end
  
end
#
# ######## Delete a Goal ############
# feature "Delete a goal" do
#
#   scenario "Show page should have a delete button" do
#   end
#
#   scenario "Edit page should have a delete button" do
#   end
#
#   scenario "Index page should have a delete button for each goal" do
#
#   end
#
#   scenario "After deletion user is redirected to index page" do
#
#   end
#
#   scenario "After deletion entry no longer has a show page" do
#
#   end
#
#   scenario "After deletion entry should be deleted from database" do
#
#   end
#
#   scenario "Only creator can delete their goal" do
#
#   end
#
# end
#
#
# ######## Edit a Goal ############
#
# feature "Edit a goal" do
#
#   scenario "Show page should have a edit button" do
#   end
#
#   scenario "Index page should have a edit button for each goal" do
#
#   end
#
#
#   scenario "After editing entry redirect user to show page on success" do
#
#   end
#
#   scenario "After editing entry user is notified of successful update" do
#
#   end
#
#   scenario "After editing entry, redirect to edit page on failure" do
#
#   end
#
#   scenario "After editing entry, keep pre-filled inputs on failure" do
#
#   end
#
#   scenario "After edit and sign out, updated version is persisted" do
#
#   end
#
#   scenario "After edit, updated version is updated to viewable users" do
#
#   end
#
#   scenario "Only creator can edit their goal" do
#
#   end
#
# end
# ######## Cheer a Goal ############
#
# ######## Comment on Goal ############
#
# ######## Goal visibility ############