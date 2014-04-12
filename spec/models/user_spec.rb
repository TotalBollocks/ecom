require 'spec_helper'

describe User do
  
  describe "validations" do
    it "requires an @ in email" do
      user = FactoryGirl.build(:user, email: "noatsymbollol")
      user.should_not be_valid
      user.errors[:email].should include "is invalid"
    end
    
    it "requires email" do
      user = FactoryGirl.build :user, email: ""
      user.should_not be_valid
      user.errors[:email].should include "can't be blank"
    end
    
    it "requires unique email" do
      FactoryGirl.create :user, email: "dup@dup.com"
      user = FactoryGirl.build :user, email: "dup@dup.com"
      user.should_not be_valid
      user.errors[:email].should include "has already been taken"
    end
      
    it "ignores case in checking for uniqueness" do
      FactoryGirl.create :user, email: "lol@lol.com"
      user = FactoryGirl.build :user, email: "LOL@LOL.COM"
      user.should_not be_valid
      user.errors[:email].should include "has already been taken"
    end
    
    it "requires matching password and confirmation" do
      user = FactoryGirl.build(:user, password: "foobar", password_confirmation: "wrong")
      user.should_not be_valid
      user.errors[:password_confirmation].should include "doesn't match Password"
    end
    
    it "requires password" do
      user = FactoryGirl.build :user, password: ""
      user.should_not be_valid
      user.errors[:password].should include "can't be blank"
    end
    
    it "requires confirmation" do
      user = FactoryGirl.build :user, password_confirmation: ""
      user.should_not be_valid
      user.errors[:password_confirmation].should include "can't be blank"
    end
  end
  
  it "has valid user factory" do
    FactoryGirl.build(:user).should be_valid
  end
  
  it "has valid admin factory" do
    FactoryGirl.build(:admin).should be_valid
  end
  
  it "defaults admin to true" do
    user = User.new
    user.admin.should be_false
  end
  
  it "downcases email before saving" do
    user = FactoryGirl.create :user, email: "LOL@LOL.COM"
    user.email.should eq "lol@lol.com"
  end
end
