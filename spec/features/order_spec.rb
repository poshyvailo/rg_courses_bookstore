require 'rails_helper'

feature 'Order' do

  let(:customer) { create :customer_with_order }

  let(:customer_delivery) do
    customer = create :customer_with_order

  end

  background do
    login_as customer, scope: :customer
    visit cart_path
    click_link 'checkout-btn-xs'
  end

  scenario 'Address Step' do


    visit order_checkout_path(customer.orders.first, :address)

    # within '#new_customer' do
    #   fill_in 'customer_email', with: customer.email
    #   fill_in 'customer_password', with: customer.password
    #   click_button('Sign In')
    # end
    # expect(page).to have_current_path root_path
    expect(page).to have_content 'Checkout'
    expect(page).to have_content 'Billing Address'
    expect(page).to have_content 'Shipping Address'
  end

  scenario 'Address Step' do
    order = customer.orders.first
    order.billing_address = create :address
    order.shipping_address = create :address
    order.order_step = 'address'
    order.save

    visit order_checkout_path(customer.orders.first, :delivery)

    # within '#new_customer' do
    #   fill_in 'customer_email', with: customer.email
    #   fill_in 'customer_password', with: customer.password
    #   click_button('Sign In')
    # end
    # expect(page).to have_current_path root_path
    expect(page).to have_content 'Checkout'
    expect(page).to have_content 'Standard'
    expect(page).to have_content 'Expedited'
  end

end