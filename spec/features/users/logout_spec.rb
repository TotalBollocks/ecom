require 'spec_helper'

feature "logging out" do
  let(:user) { FactoryGirl.create :user }
  
  scenario "user can log out" do
    visit '/'
    sign_in_as user
    click_link "Logout"
    
    page.should have_content "You have logged out"
  end
end