require 'rails_helper'

feature 'Checkout Address step' do

  let(:order) { create :order_address_step }
  let(:address) { build :address }

  background do
    login_as order.customer, scope: :customer
  end

  scenario 'Customer correct fill address forms' do
    visit order_checkout_path(order, :address)

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
      click_button t('checkout.continue_btn')
    end

    expect(page).to have_current_path order_checkout_path(order, :delivery)
    expect(page).to have_content t('shipping.method')
  end

  scenario 'Customer incorrect fill address forms' do
    visit order_checkout_path(order, :address)

    click_button t('checkout.continue_btn')

    expect(page).to have_current_path order_checkout_path(order, :address)
  end

  scenario 'Customer use "Use Billing Address" checkbox' do
    visit order_checkout_path(order, :address)

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
      click_button t('checkout.continue_btn')
    end

    expect(page).to have_current_path order_checkout_path(order, :delivery)
    expect(page).to have_content t('shipping.method')
  end

  %i[delivery payment confirm complete].each do |step|
    scenario "Redirect to address step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(order, step)

      expect(page).to have_current_path order_checkout_path(order, :address)
      expect(page).to have_content t('address.billing')
      expect(page).to have_content t('address.shipping')
    end
  end
end