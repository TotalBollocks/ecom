# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "Item_#{n}"
  end
  
  factory :item do
    name 
    price 5.99
  end
  
  factory :invalid_item, parent: :item do
    name ""
  end
end
