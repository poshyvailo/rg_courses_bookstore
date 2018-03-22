require 'rails_helper'

feature 'Sign In' do

  let(:customer) {create(:customer)}

  scenario 'Customer sign in successfully' do
    visit new_customer_session_url
    within '#new_customer' do
      fill_in 'customer_email', with: customer.email
      fill_in 'customer_password', with: customer.password
      click_button t('auth.sign_in')
    end
    expect(page).to have_current_path root_path
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Customer did not enter e-mail and password' do
    visit new_customer_session_url
    within '#new_customer' do
      click_button t('auth.sign_in')
    end
    expect(page).to have_current_path new_customer_session_path
    expect(page).to have_content 'Invalid Email or password'
  end

  scenario 'Customer did not enter password' do
    visit new_customer_session_url
    within '#new_customer' do
      fill_in 'customer_email', with: customer.email
      click_button t('auth.sign_in')
    end
    expect(page).to have_current_path new_customer_session_path
    expect(page).to have_content 'Invalid Email or password'
  end

  scenario 'Customer did not enter e-mail' do
    visit new_customer_session_url
    within '#new_customer' do
      fill_in 'customer_password', with: customer.password
      click_button t('auth.sign_in')
    end
    expect(page).to have_current_path new_customer_session_path
    expect(page).to have_content 'Invalid Email or password'
  end

  scenario 'Customer click "Forgot password?" link' do
    visit new_customer_session_url
    within '#new_customer' do
      click_link t('auth.forgot_password')
    end
    expect(page).to have_current_path new_customer_password_path
  end

  scenario 'Customer click "Sign Up" link' do
    visit new_customer_session_url
    within 'p.text-center' do
      click_link t('auth.sign_up')
    end
    expect(page).to have_current_path new_customer_registration_path
  end

end