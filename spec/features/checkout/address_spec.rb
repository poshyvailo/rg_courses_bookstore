require 'rails_helper'

feature 'Checkout Address step' do

  let(:customer) { create :customer_with_order }
  let(:address) { build :address }

  background do
    login_as customer, scope: :customer
  end

  scenario 'Customer correct fill address forms' do
    visit order_checkout_path(customer.orders.first, :address)

    within '#addresses' do
      %w[billing shipping].each do |type|
        fill_in "order_#{type}_address_attributes_firstname", with: address.firstname
        fill_in "order_#{type}_address_attributes_lastname", with: address.lastname
        fill_in "order_#{type}_address_attributes_delivery_address", with: address.delivery_address
        fill_in "order_#{type}_address_attributes_city", with: address.city
        fill_in "order_#{type}_address_attributes_zipcode", with: address.zipcode
        select 'Argentina', from: "order_#{type}_address_attributes_country"
        fill_in "order_#{type}_address_attributes_phone", with: address.phone
      end
      click_button('Save and Continue')
    end

    expect(page).to have_current_path order_checkout_path(customer.orders.first, :delivery)
    expect(page).to have_content 'Shipping Medhod'
  end

  scenario 'Customer incorrect fill address forms' do
    visit order_checkout_path(customer.orders.first, :address)

    click_button('Save and Continue')

    expect(page).to have_current_path order_checkout_path(customer.orders.first, :address)
    expect(page).to have_content "Firstname can't be blank"
    expect(page).to have_content "Lastname can't be blank"
    expect(page).to have_content "Delivery address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "Zipcode can't be blank"
    expect(page).to have_content "Country can't be blank"
    expect(page).to have_content "Phone can't be blank"
  end

  scenario 'Customer use "Use Billing Address" checkbox' do
    visit order_checkout_path(customer.orders.first, :address)

    within '#addresses' do
      %w[billing].each do |type|
        fill_in "order_#{type}_address_attributes_firstname", with: address.firstname
        fill_in "order_#{type}_address_attributes_lastname", with: address.lastname
        fill_in "order_#{type}_address_attributes_delivery_address", with: address.delivery_address
        fill_in "order_#{type}_address_attributes_city", with: address.city
        fill_in "order_#{type}_address_attributes_zipcode", with: address.zipcode
        select 'Argentina', from: "order_#{type}_address_attributes_country"
        fill_in "order_#{type}_address_attributes_phone", with: address.phone
      end
      check 'use_billing_address', visible: false
      click_button('Save and Continue')
    end

    expect(page).to have_current_path order_checkout_path(customer.orders.first, :delivery)
    expect(page).to have_content 'Shipping Medhod'
  end

  %i[delivery payment confirm complete].each do |step|
    scenario "Redirect to address step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(customer.orders.first, step)

      expect(page).to have_current_path order_checkout_path(customer.orders.first, :address)
      expect(page).to have_content 'Billing Address'
      expect(page).to have_content 'Shipping Address'
    end
  end
end