require 'rails_helper'

feature 'Cart page' do

  let(:customer) { create :customer_with_order}

  background do
    login_as customer, scope: :customer
  end

  scenario 'Customer enter valid coupon' do
    coupon = create :coupon
    visit cart_path
    fill_in 'coupon', with: coupon.name
    click_button t('cart.update_cart')

    expect(page).to have_content t('cart.msg.coupon_added')
  end

  scenario 'Customer enter invalid coupon' do
    visit cart_path
    fill_in 'coupon', with: 'invalid coupon'
    click_button t('cart.update_cart')

    expect(page).to have_content t('cart.msg.coupon_not_found')
  end

  scenario 'Customer enter used coupon' do
    coupon = create :used_coupon
    visit cart_path
    fill_in 'coupon', with: coupon.name
    click_button t('cart.update_cart')

    expect(page).to have_content t('cart.msg.coupon_used')
  end
end