require 'rails_helper'

feature 'Orders' do

  let (:customer) { create :customer }

  background do
    Order.aasm.states.map(&:name).each do |state|
      create :completed_order, state: state, customer: customer
    end

    login_as customer, scope: :customer
  end

  context 'Orders list' do
    scenario 'Customer go to orders' do
      visit customers_orders_path
      within '.table-hover tbody' do
        expect(page).to have_css 'tr', count: (Order.aasm.states.count - 1)
      end
    end
  end

  context 'View order' do

  end

end