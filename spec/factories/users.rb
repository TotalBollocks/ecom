# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@lol.com"
  end
  factory :user do
    email
    password "foobar"
    password_confirmation "foobar"
    admin false
    
    factory :admin do
      admin true
    end
  end
end
