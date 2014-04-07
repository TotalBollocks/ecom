require 'spec_helper'

describe UsersController do
  describe 'get #new' do
    it "assigns new user" do
      get :new
      assigns(:user).should be_new_record
    end
    
    it "renders new template" do
      get :new
      response.should render_template "new"
    end
  end
  
  describe "put #create" do
    context "success" do
      let(:user_params) { FactoryGirl.attributes_for :user }
      
      it "creates a user" do
        expect do
          put :create, user: user_params
        end.to change(User, :count).by 1
      end
      
      it "redirects to items" do
        put :create, user: user_params
        response.should redirect_to items_path
      end
    end
    
    context "failure" do
      let(:bad_params) { FactoryGirl.attributes_for(:user, email: "") }
      
      it "does not create a user" do
        expect do
          put :create, user: bad_params
        end.not_to change User, :count
      end
      
      it "renders the new template" do
        put :create, user: bad_params
        response.should render_template "new"
      end
      
      it "assigns new user" do
        put :create, user: bad_params
        assigns(:user).should be_new_record
      end
    end
  end
end
