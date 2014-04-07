require 'spec_helper'

describe 'items/index.html.erb' do
  
  it "displays all items" do
    items = assign(:items,
    [FactoryGirl.create(:item, name: "one"),
    FactoryGirl.create(:item, name: "two"),
    FactoryGirl.create(:item, name: "three")])
    render
    
    items.each do |item|
      rendered.should have_content item.name
    end
  end
  
  context "logged in" do
    let(:user) { FactoryGirl.create :user }
    let(:item) { FactoryGirl.create :item }
    
    before do
      sign_in user
      assign(:items, [item])
      render
    end
    
    it "displays edit link" do
      rendered.should have_link "Edit"
    end
    
    it "displays delete link" do
      rendered.should have_link "Delete"
    end
    
    it "displays new item link" do
      rendered.should have_link "New Item"
    end
  end
  
  context "not logged in" do
    let(:item) { FactoryGirl.create :item }
    
    before do
      assign(:items, [item])
      render
    end
    
    it "doesnt display edit link" do
      rendered.should_not have_link "Edit"
    end
    
    it "doesnt display delete link" do
      rendered.should_not have_link "Delete"
    end
    
    it "doesnt display new item link" do
      rendered.should_not have_link "New Item"
    end
  end
end