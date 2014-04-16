require 'spec_helper'

feature "Creating Items" do
  before do
    visit '/'
    sign_in_as FactoryGirl.create(:admin)
    click_link "New Item"
  end
  
  it "creates a new item" do
    fill_in "Name", with: "Product"
    fill_in "Price", with: 5.99
    click_button "Create Item"
    
    expect(page).to have_content "Item has been created"
    expect(page).to have_content "Product"
    expect(page).to have_content "$5.99"
  end
  
  it "doesn't create item with invalid params" do
    click_button "Create Item"
    
    expect(page).to have_content "Item has not been created"
  end
end