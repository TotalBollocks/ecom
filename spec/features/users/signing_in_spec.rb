require 'spec_helper'

feature "Signing in" do
  let(:user) { FactoryGirl.create :user }
  
  before do
    visit '/'
    click_link "Sign in"
  end
  
  scenario "user signs in correctly" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    
    page.should have_content "You have logged in"
  end
  
  scenario "user signs in with invalid email/password" do
    fill_in "Email", with: user.email
    fill_in "Password", with: "Wrong"
    click_button "Sign in"
    
    page.should have_content "Email or password is incorrect"
  end
end