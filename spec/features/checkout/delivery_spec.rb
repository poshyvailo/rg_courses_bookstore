require 'rails_helper'

feature 'Checkout Delivery step' do

  before(:all) do
    5.times do
      create :delivery_method
    end
  end

  let(:order) { create :order_delivery_step }

  background do
    login_as order.customer, scope: :customer
  end

  scenario 'Customer select delivery method' do
    visit order_checkout_path(order, :delivery)

    within '#delivery-methods' do
      choose option: DeliveryMethod.first.id, visible: false
      click_button('Save and Continue')
    end

    expect(page).to have_current_path order_checkout_path(order, :payment)
  end

  scenario 'Customer not select delivery method' do
    visit order_checkout_path(order, :delivery)
    click_button('Save and Continue')

    expect(page).to have_current_path order_checkout_path(order, :delivery)
  end

  %i[address payment confirm complete].each do |step|
    scenario "Redirect to delivery step if customer try go to #{step.to_s} step" do
      visit order_checkout_path(order, step)

      expect(page).to have_current_path order_checkout_path(order, :delivery)
      expect(page).to have_content 'Shipping Medhod'
    end
  end
end