require 'spec_helper'

feature "deleteing items" do
  let!(:item) { FactoryGirl.create :item, name: "Item_1" }
  
  scenario "deleting an item" do
    visit '/'
    within("##{item.name}") { click_link "Delete" }
    
    page.should have_content "Item has been deleted"
    page.should_not have_content item.name
  end
end