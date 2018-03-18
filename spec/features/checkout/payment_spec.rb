require 'rails_helper'

feature 'Checkout Payment step' do

  let(:customer) do
    customer = create :customer_with_order
    customer.orders.first.update({
      billing_address: create(:address),
      shipping_address: create(:address),
      delivery_method: create(:delivery_method),
      order_step: 'delivery'
    })
    customer
  end

  background do
    login_as customer, scope: :customer
  end

  scenario 'Customer fill valid credit card data' do

  end

  scenario 'Customer fill wrong credit card data' do

  end

  %i[address delivery confirm complete].each do |step|
    scenario "Redirect to delivery step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(customer.orders.first, step)

      expect(page).to have_current_path order_checkout_path(customer.orders.first, :payment)
      expect(page).to have_content 'Credit Card'
    end
  end
end