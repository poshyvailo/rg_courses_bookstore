require 'rails_helper'

feature 'Checkout Confirm step' do

  let(:order) { create :order_confirm_step }

  background do
    login_as order.customer, scope: :customer
  end

  scenario 'Customer click "Place Order" button' do

  end

  scenario "Redirect to confirm step if customer try go to complete step" do
    visit order_checkout_path(order, step)
    expect(page).to have_current_path order_checkout_path(order, :confirm)
  end
end