require 'rails_helper'

feature 'Checkout Confirm step' do

  let(:order) { create :order_confirm_step }
  let(:address) { build :address }

  background do
    login_as order.customer, scope: :customer
  end

  scenario 'Customer click "Place Order" button' do
    visit visit order_checkout_path(order, :confirm)
    click_button 'Place Order'
    expect(page).to have_current_path order_checkout_path(order, :complete)
  end

  context 'Step access' do
    scenario "Redirect to confirm step if customer try go to complete step" do
      visit order_checkout_path(order, :complete)
      expect(page).to have_current_path order_checkout_path(order, :confirm)
    end
  end

  context 'Edit order data' do
    context 'Update address' do
      background do
        visit visit order_checkout_path(order, :confirm)
        click_link 'edit-billing-address'
      end

      scenario 'Customer change address and enter valid data' do
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

        expect(page).to have_current_path order_checkout_path(order, :confirm)
        expect(page).to have_content(address.firstname)
        expect(page).to have_content(address.lastname)
        expect(page).to have_content(address.delivery_address)
        expect(page).to have_content(address.city)
        expect(page).to have_content(address.phone)
      end

      scenario 'Customer change address and enter invalid data' do
        within '#addresses' do
          %w[billing shipping].each do |type|
            fill_in "order_#{type}_address_attributes_firstname", with: ''
          end
          click_button('Save and Continue')
        end

        expect(page).to have_current_path order_checkout_path(order, :address)
      end
    end

    context 'Update delivery method' do
      background do
        5.times { create :delivery_method }
        visit visit order_checkout_path(order, :confirm)
        click_link 'edit-delivery-method'
      end

      scenario 'Customer change delivery method' do
        within '#delivery-methods' do
          choose option: DeliveryMethod.first.id, visible: false
          click_button('Save and Continue')
        end

        expect(page).to have_current_path order_checkout_path(order, :confirm)
        expect(page).to have_content(DeliveryMethod.first.name)
      end
    end

    # context 'Update credit card method' do
    #   background do
    #     visit visit order_checkout_path(order, :confirm)
    #     click_link 'edit-payment'
    #   end
    #
    #   scenario 'Customer change credit card and enter valid data' do
    #     within '#credit-card' do
    #       fill_in 'order_credit_card_attributes_number', with: credit_card.number
    #       fill_in 'order_credit_card_attributes_card_owner', with: credit_card.card_owner
    #       fill_in 'order_credit_card_attributes_cvv', with: credit_card.cvv
    #       fill_in 'order_credit_card_attributes_expiration', with: '10 / 20'
    #       click_button('Save and Continue')
    #     end
    #
    #     expect(page).to have_current_path order_checkout_path(order, :confirm)
    #     expect(page).to have_content(DeliveryMethod.first.name)
    #   end
    # end
  end
end