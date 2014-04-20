require 'spec_helper'

feature "buying items" do
  let(:user) { FactoryGirl.create :user }
  let!(:item) { FactoryGirl.create :item }
  
  before do
    sign_in_as user
    visit '/'
    within("##{item.name}") do
      click_link "Buy"
    end
  end
  
  specify {page.should have_content item.name}
  specify {page.should have_button "Pay #{item.price}"}
  
  describe "successful payment" do
    before do
      fill_in "Card Number", with: '4242-4242-4242-4242'
      fill_in "CVC", with: '123'
      select "January", from: "exp_month"
      select "2022", from: "exp_year"
      click_button "Pay #{item.price}"
    end
    
    specify{ page.should have_content "Item has been purchased"}
  end
end