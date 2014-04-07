require 'spec_helper'

feature "Signing up" do
  
  before do
    visit '/'
    click_link "Sign up"
  end
  
  context "successful sign up" do
    
    scenario "new user signing up" do    
      fill_in "Email", with: "lol@lol.com"
      fill_in "Password", with: "foobar"
      fill_in "Password Confirmation", with: "foobar"
      click_button "Sign up"
    
      page.should have_content "You have signed up"
    end
  end
  
  context "unsuccessful sign up" do
    scenario "signing up with invalid attrs" do
      click_button "Sign up"
      
      page.should have_content "Email can't be blank"
    end
  end
end