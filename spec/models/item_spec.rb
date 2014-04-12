require 'spec_helper'

describe Item do
  
  describe "validations" do
    it "requires name" do
      user = FactoryGirl.build(:item, name: "")
      user.should_not be_valid
      user.errors[:name].should include "can't be blank"
    end
    
    it "requires price" do
      user = FactoryGirl.build(:item, price: nil)
      user.should_not be_valid
      user.errors[:price].should include "can't be blank"
    end
  end
  
  it "has working factory" do
    FactoryGirl.build(:item).should be_valid
  end
end
