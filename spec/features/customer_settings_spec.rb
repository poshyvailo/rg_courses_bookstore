require 'rails_helper'

feature 'Customer Settings' do

  let(:customer) { create :customer}
  let(:address) { create :address }

  background do
    login_as customer, scope: :customer
    visit customer_path
  end

  context 'Address tab' do
    background do
      click_link 'Address'
    end
    scenario 'Customer enter valid shipping address' do
      within '#shipping-address' do
          fill_in 'customer_shipping_address_attributes_firstname', with: address.firstname
          fill_in 'customer_shipping_address_attributes_lastname', with: address.lastname
          fill_in 'customer_shipping_address_attributes_delivery_address', with: address.delivery_address
          fill_in 'customer_shipping_address_attributes_city', with: address.city
          fill_in 'customer_shipping_address_attributes_zipcode', with: address.zipcode
          select 'Argentina', from: 'customer_shipping_address_attributes_country'
          fill_in 'customer_shipping_address_attributes_phone', with: address.phone
          click_button t('general.save')
      end

      expect(page).to have_content 'Shipping address successfully changed'
    end

    scenario 'Customer enter invalid shipping address' do
      within '#shipping-address' do
        click_button t('general.save')
      end

      expect(page).to have_content 'Firstname can\'t be blank'
    end

    scenario 'Customer enter valid billing address' do
      within '#billing-address' do
        fill_in 'customer_billing_address_attributes_firstname', with: address.firstname
        fill_in 'customer_billing_address_attributes_lastname', with: address.lastname
        fill_in 'customer_billing_address_attributes_delivery_address', with: address.delivery_address
        fill_in 'customer_billing_address_attributes_city', with: address.city
        fill_in 'customer_billing_address_attributes_zipcode', with: address.zipcode
        select 'Argentina', from: 'customer_billing_address_attributes_country'
        fill_in 'customer_billing_address_attributes_phone', with: address.phone
        click_button t('general.save')
      end

      expect(page).to have_content 'Billing address successfully changed'
    end

    scenario 'Customer enter invalid billing address' do
      within '#billing-address' do
        click_button t('general.save')
      end

      expect(page).to have_content 'Firstname can\'t be blank'
    end
  end

  context 'Privacy tab' do
    background do
      click_link 'Privacy'
    end

    scenario 'Customer change email' do
      email = FFaker::Internet.email
      within '#change-email' do
        fill_in 'customer_email', with: email
        click_button t('general.save')
      end

      expect(customer.email) == email
    end

    scenario 'Customer change password' do
      new_password = 'XYz156WKp9'
      within '#change-password' do
        fill_in 'customer_current_password', with: customer.password
        fill_in 'customer_password', with: new_password
        fill_in 'customer_password_confirmation', with: new_password
        click_button t('general.save')
      end

      expect(page).to have_content 'Password successfully changed'
    end

    scenario 'Customer delete account' do
      within '#remove-account' do
        click_button 'Please Remove My Account', disabled: true
      end

      expect(page).to have_current_path root_path
      # expect(page).to have_content 'Password successfully changed'
    end
  end
end