module FeatureHelper
  def sign_in(customer, location = nil)
    visit new_customer_session_path
    fill_in 'email', with: customer.email
    fill_in 'password', with: customer.password
    click_button('Sign In')
    visit(location) if location
  end
end