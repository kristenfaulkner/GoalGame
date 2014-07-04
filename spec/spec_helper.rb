# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def sign_up(username, password)
  visit "/users/new"
  fill_in "Username", with: username
  fill_in "Password", with: password
  click_button 'Sign Up'
end

def sign_in(username, password)
  visit "/session/new"
  fill_in "Username", with: username
  fill_in "Password", with: password
  click_button 'Sign In'
end

def sign_out
  click_button 'Sign Out'
end

def create_goal(title, body)
  sign_up("kirsten", "kirsten")
  visit new_goal_url
  fill_in "Title", with: title
  fill_in "Body", with: body
  click_button "Create Goal"
end

def delete_goal
  click_button "Delete Goal"  
end

def edit_goal(title, body)
  click_button "Edit Goal"
  fill_in "Title", with: title
  fill_in "Body", with: body
  click_button "Update Goal"
end

def goal_created?(goal)
  Goal.all.include?(goal)
end
