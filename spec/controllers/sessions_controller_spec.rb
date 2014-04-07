require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "renders new template" do
      get :new
      response.should render_template 'new'
    end
  end
  
  describe "PUT create" do
    context "correct email/password" do
      let(:user) { FactoryGirl.create :user }
      
      it "stores user_id session" do
        put :create, email: user.email, password: user.password
        session['user_id'].should eq user.id    
      end
      
      it "redirects to items" do
        put :create, email: user.email, password: user.password
        response.should redirect_to items_path
      end
    end
    
    context "wrong email/password" do
      let(:user) { FactoryGirl.create :user }
      
      it "gives alert if wrong email" do
        put :create, email: "Not@email.com", password: user.password
        flash[:alert].should eq "Email or password is incorrect"
      end
      
      it "gives alert if wrong password" do
        put :create, email: user.email, password: "wrong"
        flash[:alert] = "Email or password is incorrect"
      end
      
      it "renders the new template" do
        put :create, email: user.email, password: "wrong"
        response.should render_template "new"
      end
    end
  end
  
  describe "delete #destroy" do
    
    it "set user_id session to nil" do
      delete :destroy
      session['user_id'].should be_nil
    end
    
    it "redirects to root" do
      delete :destroy
      response.should redirect_to root_path
    end
  end

end
