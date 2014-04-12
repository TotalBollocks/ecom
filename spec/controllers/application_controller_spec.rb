require 'spec_helper'

# test controller

describe ApplicationController do
  let(:admin) { FactoryGirl.create :admin }
  let(:user) { FactoryGirl.create :user }
  
  describe ".require_admin" do

    controller do
      before_action :require_admin
      
      def show
        render text: "hello"
      end
    end
    
    before do
      get :show, id: 1
    end

    context "anonymous user logged in" do
      before do
        sign_in user
      end
      
      specify{response.should be_redirect} #to items path for now
      specify{flash[:alert].should eq "You do not have permission to do this"}
    end
    
    context "not signed in" do
      
      specify{response.should be_redirect} #to items path for now
      specify{flash[:alert].should eq "You do not have permission to do this"}
    end
  end
end