
require 'capybara/rspec'
require './app/server'

Capybara.app = Sinatra::Application.new
ENV["RACK_ENV"] = 'test' 
require 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

  def sign_in(email, password)
  visit '/sessions/new'
  fill_in :email, :with => email
  fill_in :password, :with => password
  click_button 'Sign in'
end


  def sign_up(email = "alice@example.com", 
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
end
