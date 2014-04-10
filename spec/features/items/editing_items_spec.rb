require 'spec_helper'

feature "editing items" do
  let(:user) { FactoryGirl.create :user }
  let!(:item) { FactoryGirl.create :item }

  context "user logged in" do
    
  before do
    visit '/'
    sign_in_as(user)
    within "##{item.name}" do
      click_link "Edit"
    end
  end
  
  scenario "edit with valid attrs" do
    fill_in "Name", with: "New Name"
    click_button "Update Item"
    
    page.should have_content "Item has been updated"
  end
  
  scenario "edit with invalid attrs" do
    fill_in "Name", with: ""
    click_button "Update Item"
    
    page.should have_content "Item has not been updated"
  end
    
  end
  
end