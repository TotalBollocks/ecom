require 'spec_helper'

describe ItemsController do
  let(:admin) { FactoryGirl.create :admin }
  let(:item) {FactoryGirl.create :item}

  before { sign_in admin }
  
  describe "#create" do
    context "success" do
      it "creates a new item" do
        expect do
          put :create, item: FactoryGirl.attributes_for(:item)
        end.to change(Item, :count).by 1
      end
      
      it "redirects to index" do
        put :create, item: FactoryGirl.attributes_for(:item)
        response.should redirect_to items_path
      end
    end
    
    context "failure" do
      it "doesnt create a new user" do
        expect do
          put :create, item: FactoryGirl.attributes_for(:invalid_item)
        end.not_to change Item, :count
      end
    end
  end
    
  describe "#update" do
    context "valid attributes" do
      it "changes attributes" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "Diff", price: 96.45)
        item.reload
        item.name.should eq "Diff"
        item.price.should eq 96.45
      end
      
      it "redirects to index" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "Diff")
        response.should redirect_to items_path
      end
    end
    
    context "invalid attributes" do
      it "Doesnt change attributes" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "   ", price: 99.99)
        item.reload
        item.name.should_not be_blank
        item.price.should_not eq 99.99
      end
      
      it "renders edit" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "   ", price: 99.99)
        response.should render_template :edit
      end
    end
  end
    
  describe "#destroy" do
    let!(:item) {FactoryGirl.create :item}
    
    it "deletes an item" do
      expect do
        delete :destroy, id: item
      end.to change(Item, :count).by -1
    end
   
    it "redirects to index" do
      delete :destroy, id: item
      response.should redirect_to items_path
    end
  end
  
end