require 'rails_helper'

feature 'Sign Up' do

  scenario 'Customer registers successfully via register form' do
    visit new_customer_registration_url
    within '#new_customer' do
      fill_in 'customer_email', with: FFaker::Internet.free_email
      fill_in 'customer_password', with: '12345678'
      fill_in 'customer_password_confirmation', with: '12345678'
      click_button t('auth.sign_up')
    end
    expect(page).to have_content t('devise.registrations.signed_up_but_unconfirmed')
  end

  scenario 'Customer did not enter e-mail and password' do
    visit new_customer_registration_url
    within '#new_customer' do
      click_button t('auth.sign_up')
    end
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'Customer enter wrong confirmation password' do
    visit new_customer_registration_url
    within '#new_customer' do
      fill_in 'customer_email', with: FFaker::Internet.free_email
      fill_in 'customer_password', with: '12345678'
      fill_in 'customer_password_confirmation', with: '87654321'
      click_button t('auth.sign_up')
    end
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'Customer enter exists email' do
    customer = create(:customer)
    visit new_customer_registration_url
    within '#new_customer' do
      fill_in 'customer_email', with: customer.email
      fill_in 'customer_password', with: '12345678'
      fill_in 'customer_password_confirmation', with: '12345678'
      click_button t('auth.sign_up')
    end
    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Customer click "Sign In" link' do
    visit new_customer_registration_url
    within 'p.text-center' do
      click_link t('auth.sign_in')
    end
    expect(page).to have_current_path new_customer_session_path
  end

end