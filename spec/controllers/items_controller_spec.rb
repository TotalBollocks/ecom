require 'spec_helper'

describe ItemsController do
  let(:admin) { FactoryGirl.create :admin }
  let(:user) { FactoryGirl.create :user }
  let(:item) {FactoryGirl.create :item}

  describe "templates" do
    before { sign_in admin }
    
    describe "#index" do
      before { get :index }
      specify { response.should render_template :index }
    end
    
    describe "#show" do
      before {get :show, id: item }
      specify { response.should render_template :show } 
    end
    
    describe "#new" do
      before {get :new}
      specify { response.should render_template :new }
    end
    
    describe "#edit" do
      before {get :edit, id: item}
      specify { response.should render_template :edit }
    end
  end
  
  describe "instance variables" do
    before { sign_in admin }
    
    describe "#index" do
      let(:item_1) {FactoryGirl.create :item}
      let(:item_2) {FactoryGirl.create :item}
      let(:item_3) {FactoryGirl.create :item}
      before { get :index }
      specify { assigns(:items).should eq [item_1, item_2, item_3] }
    end
    
    describe "#show" do
      before {get :show, id: item}
      specify { assigns(:item).should eq item }
    end
    
    describe "#new" do
      before {get :new}
      specify { assigns(:item).should be_new_record }
    end
    
    describe "#create" do
      context "successful" do
        before {put :create, item: FactoryGirl.attributes_for(:item)}
        specify {assigns(:item).should be_persisted}
      end
      
      context "failure" do
        before {put :create, item: FactoryGirl.attributes_for(:invalid_item)}
        specify {assigns(:item).should be_new_record}
      end
    end
    
    describe "#edit" do
      before {get :edit, id: item}
      specify { assigns(:item).should eq item }
    end
    
    describe "#update" do
      before {patch :update, id: item, item: FactoryGirl.attributes_for(:item)}
      specify {assigns(:item).should eq item}
    end
    
    describe "#destroy" do
      before {delete :destroy, id: item}
      specify { assigns(:item).should eq item }
    end
  end
  
  describe "behaviors" do
    before do
        sign_in admin
    end
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
          patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "Diff")
          item.reload
          item.name.should eq "Diff"
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
    end
  end
end