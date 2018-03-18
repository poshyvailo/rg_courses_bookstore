require 'rails_helper'

feature 'Checkout Delivery step' do

  before(:all) do
    5.times do
      create :delivery_method
    end
  end

  let(:customer) do
    customer = create :customer_with_order
    customer.orders.first.update({
      billing_address: create(:address),
      shipping_address: create(:address),
      order_step: 'address'
    })
    customer
  end

  background do
    login_as customer, scope: :customer
  end

  scenario 'Customer select delivery method' do
    visit order_checkout_path(customer.orders.first, :delivery)

    within '#delivery-methods' do
      choose option: '2', visible: false
      click_button('Save and Continue')
    end

    expect(page).to have_current_path order_checkout_path(customer.orders.first, :payment)
  end

  scenario 'Customer not select delivery method' do
    visit order_checkout_path(customer.orders.first, :delivery)
    click_button('Save and Continue')

    expect(page).to have_current_path order_checkout_path(customer.orders.first, :delivery)
  end

  %i[address payment confirm complete].each do |step|
    scenario "Redirect to delivery step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(customer.orders.first, step)

      expect(page).to have_current_path order_checkout_path(customer.orders.first, :delivery)
      expect(page).to have_content 'Shipping Medhod'
    end
  end
end