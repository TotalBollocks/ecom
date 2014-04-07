require 'spec_helper'

describe ItemsController do
  let(:user) { FactoryGirl.create :user }
  describe 'get #index' do
    it "assigns array of items" do
      item1 = FactoryGirl.create :item, name: "Item 1"
      item2 = FactoryGirl.create :item, name: "Item 2"
      item3 = FactoryGirl.create :item, name: "Item 3"
      get :index
      assigns(:items).should eq [item1, item2, item3]
    end
    
    it "renders index template" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "get #show" do
    let(:item) { FactoryGirl.create :item }
    
    it "assigns proper item" do
      get :show, id: item
      assigns(:item).should eq item
    end
    
    it "renders show template" do
      get :show, id: item
      response.should render_template :show
    end
  end
  
  describe "get #new" do
    context "signed in" do
      
      before do
        sign_in user
      end
      
      it "assigns new item" do
        get :new
        assigns(:item).should be_new_record
      end
      
      it "renders new template" do
        get :new
        response.should render_template :new
      end
    end
    
    context "not signed in" do
      it "redirects to index" do
        get :new
        response.should redirect_to items_path
      end
    end
  end
  
  describe "put #create" do
    context "signed in" do
      before do
        sign_in user
      end
      
      context "with valid parameters" do 
        it "creates a new item" do
          expect do
            put :create, item: FactoryGirl.attributes_for(:item)
          end.to change(Item, :count).by 1
        end
        
        it "redirects to the index" do
          put :create, item: FactoryGirl.attributes_for(:item)
          response.should redirect_to items_path
        end
      end
      
      context "with invalid parameters" do
        it "assigns new item" do
          put :create, item: FactoryGirl.attributes_for(:invalid_item)
          assigns(:item).should be_new_record
        end
        
        it "renders new template" do
          put :create, item: FactoryGirl.attributes_for(:invalid_item)
          response.should render_template :new
        end
        
        it "doesn't create a new item" do
          expect do
            put :create, item: FactoryGirl.attributes_for(:invalid_item)
          end.to_not change Item, :count
        end
      end
    end
    
    context "not signed in" do
      it "doesnt create an item" do
        expect do
          put :create, item: FactoryGirl.attributes_for(:item)
        end.not_to change(Item, :count)
      end
      
      it "redirects to index" do
        put :create, item: FactoryGirl.attributes_for(:item)
        response.should redirect_to items_path
      end
    end
  end
  
  describe "get #edit" do
    let(:item) { FactoryGirl.create :item }
    
    context "signed in" do
      before do
        sign_in user
      end
      
      it "assigns proper item" do
        get :edit, id: item
        assigns(:item).should eq item
      end
      
      it "renders edit template" do
        get :edit, id: item
        response.should render_template :edit
      end
    end
    
    context "not signed in" do
      it "redirects to index" do
        get :edit, id: item
        response.should redirect_to items_path
      end
    end
    
  end
  
  describe "patch #update" do
    let(:item) { FactoryGirl.create :item }
    
    context "signed in" do
      before do
        sign_in user
      end
      
      it "assigns proper item" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item)
        assigns(:item).should eq item
      end
      
      context "Successful update" do
        
        it "changes the item attrs" do
          patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "Diff")
          item.reload
          item.name.should eq "Diff"
          item.price.should eq 5.99
        end
        
        it "redirects to item" do
          patch :update, id: item, item: FactoryGirl.attributes_for(:item)
          response.should redirect_to item
        end
      end
      
      context "Invalid update" do
        
        it "doesn't update" do
          patch :update, id: item, item: FactoryGirl.attributes_for(:invalid_item)
          item.reload
          item.name.should eq "Item"
        end
        
        it "renders edit template" do
          patch :update, id: item, item: FactoryGirl.attributes_for(:invalid_item)
          response.should render_template :edit
        end
      end
    end
    
    context "not signed in" do
      it "doesnt update item" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item, name: "Diff")
        item.reload
        item.name.should_not eq "Diff"
      end
      
      it "redirects to index" do
        patch :update, id: item, item: FactoryGirl.attributes_for(:item)
        response.should redirect_to items_path
      end
    end
    
  end
  
  describe "delete #destroy" do
    let!(:item) { FactoryGirl.create :item }
    
    context "signed in" do
      before do
        sign_in user
      end
      it "assigns proper item" do
        delete :destroy, id: item
        assigns(:item).should eq item
      end
      
      it "deletes the item" do
        expect do
          delete :destroy, id: item
        end.to change(Item, :count).by -1
      end
      
      it "redirect to index" do
        delete :destroy, id: item
        response.should redirect_to items_path
      end
    end
    
    context "not signed in" do
      it "doesnt delete an item" do
        expect do
          delete :destroy, id: item
        end.not_to change(Item, :count)
      end
      
      it "redirects to index" do
        delete :destroy, id: item
        response.should redirect_to items_path
      end
    end
    
  end
  
end