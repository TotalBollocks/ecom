require 'spec_helper'

describe Item do
  
  it "has working factory" do
    FactoryGirl.build(:item).should be_valid
  end
  
  it "requires name" do
    FactoryGirl.build(:item, name: "").should_not be_valid
  end
  
  it "requires price" do
    FactoryGirl.build(:item, price: nil).should_not be_valid
  end
end
