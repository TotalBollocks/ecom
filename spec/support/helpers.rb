module FeatureHelpers
  def sign_in_as(user)
    visit '/'
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

module AuthHelpers
  def sign_in(user)
    session['user_id'] = user.id
  end
end

RSpec.configure do |c|
  c.include FeatureHelpers, type: :feature
  c.include AuthHelpers
end