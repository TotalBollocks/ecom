require 'spec_helper'

describe 'items/index.html.erb' do  
  
  context "logged in" do
    let(:item) { FactoryGirl.create :item }
    
    context "as anonymous user" do      
      before do
        view.stub(:admin?) { false }
        assign(:items, [item])
        render
      end
      
      it "displays edit link" do
        rendered.should_not have_link "Edit"
      end
      
      it "displays delete link" do
        rendered.should_not have_link "Delete"
      end
      
      it "displays new item link" do
        rendered.should_not have_link "New Item"
      end
    end
    
    context "as admin" do      
      before do
        view.stub('admin?') { true }
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
  end
  
  context "not logged in" do
    let(:item) { FactoryGirl.create :item }
    
    before do
      view.stub(:admin?) { nil }
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