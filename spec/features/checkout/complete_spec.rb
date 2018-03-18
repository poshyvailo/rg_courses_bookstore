require 'rails_helper'

feature 'Checkout Complete step' do

  let(:order) { create :order_confirm_step }

  background do
    login_as order.customer, scope: :customer
    visit order_checkout_path(order, :confirm)
    within '#confirm' do
      click_button('Place Order')
    end
  end

  scenario 'Customer in complete page' do
    expect(page).to have_current_path order_checkout_path(order, :complete)
  end

  scenario 'Customer click "Back to Store" button' do
    click_link('Back to Store')
    expect(page).to have_current_path catalog_path
  end

  %i[address delivery payment confirm].each do |step|
    scenario "Redirect to complete step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(order, step)
      expect(page).to have_current_path order_checkout_path(order, :complete)
    end
  end
end