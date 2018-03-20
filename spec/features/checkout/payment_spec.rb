require 'rails_helper'

feature 'Checkout Payment step' do

  let(:order) { create :order_payment_step }
  let(:credit_card) { build :credit_card }

  background do
    login_as order.customer, scope: :customer
  end

  scenario 'Customer fill valid credit card data' do
    visit order_checkout_path(order, :payment)

    within '#credit-card' do
      fill_in 'order_credit_card_attributes_number', with: credit_card.number
      fill_in 'order_credit_card_attributes_card_owner', with: credit_card.card_owner
      fill_in 'order_credit_card_attributes_cvv', with: credit_card.cvv
      fill_in 'order_credit_card_attributes_expiration', with: '10 / 20'
      click_button('Save and Continue')
    end

    expect(page).to have_current_path order_checkout_path(order, :confirm)
  end

  scenario 'Customer fill wrong credit card data' do
    visit order_checkout_path(order, :payment)
    click_button('Save and Continue')
    expect(page).to have_current_path order_checkout_path(order, :payment)
  end

  %i[address delivery confirm complete].each do |step|
    scenario "Redirect to delivery step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(order, step)

      expect(page).to have_current_path order_checkout_path(order, :payment)
      expect(page).to have_content 'Credit Card'
    end
  end
end