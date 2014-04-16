require 'spec_helper'

feature "buying items" do
  let(:user) { FactoryGirl.create :user }
  let!(:item) { FactoryGirl.create :item }
  
  before do
    sign_in_as user
    visit '/'
    within("#item.name") do
      click_link "Buy"
    end
  end
end