require 'spec_helper'

##################  SIGN_UP ##############
feature "Sign Up" do 
  before :each do
    visit new_user_url
  end
  
  it "has a user sign up page" do
    expect(page).to have_content "Sign Up"
  end
  
  it "has a sign up button" do
    expect(page).to have_button "Sign Up"
  end
  
  it "has inputs for username and password" do
    page.should have_content "Username"
    page.should have_content "Password"
  end
  
  it "requires a username" do
    sign_up("", "password")
    page.should have_content "Username can't be blank"
  end
  
  it "requires a password" do
    sign_up("username", "")
    page.should have_content "Password is too short (minimum is 6 characters)"
  end
  
  it "validates that the password length is at least 6 characters" do
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'short'
    click_button 'Sign Up'
    page.should have_content "Sign Up"
    page.should have_content "Password is too short"
    (current_path + "/new").should == new_user_path
  end
  
  it "does not let user sign up twice" do
    sign_up("kristen", "kristen")
    sign_out
    sign_up("kristen", "kristen")
    page.should have_content 'Username has already been taken'
  end
  
end

########################   SIGN IN ###################

feature "Sign In" do
  before :each do
    visit new_session_url
  end

  scenario "has a sign in page" do
    expect(page).to have_content "Sign In"
  end
  
 scenario "has a sign in button" do
    expect(page).to have_button "Sign In"
  end
  
 scenario "has inputs for username and password" do
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end
  
 scenario "requires a username" do
    sign_in("", "password")
    expect(page).to have_content "Invalid Username"
  end
  
 scenario "requires an existing username" do
    sign_in("sdkljfhsdkljhfkjklsdfjsd", "password")
    expect(page).to have_content "Invalid Username"
  end
  
 scenario "does not let someone sign in after they've deleted their account" do
    sign_up("sdkljfhsdkljhfkjklsdfjsd", "password")
    click_button "Delete my Account"
    click_link "Sign In"
    sign_in("sdkljfhsdkljhfkjklsdfjsd", "password")
    expect(page).to have_content "Invalid Username"
  end
  
 scenario "requires a password" do
    sign_up("username", "password")
    sign_out
    sign_in("username", "")
    expect(page).to have_content "Invalid password"
  end
  
 scenario "does not let user sign up twice" do
    sign_up("kristen", "kristen")
    sign_out
    sign_up("kristen", "kristen")
    expect(page).to have_content 'Username has already been taken'
  end
  
end

  ###############   Sign Out #####################
  
feature "Sign Out" do
  before :each do
    visit new_user_url
    sign_up("appacademy", "password")
    sign_out
  end
  
  scenario "user cannot access goals page if signed out" do
    visit goals_url
    expect(page).to have_content "Sign In"
    current_path.should == new_session_path
  end
end
  
  