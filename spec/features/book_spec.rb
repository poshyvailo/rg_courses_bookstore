require 'rails_helper'

feature 'Book page' do

  let(:book) { create :book }

  scenario 'Customer click "Add to card" button' do
    visit catalog_book_path(book)
    click_button t('book.add_to_card')

    expect(page).to have_content t('book.msg.added', title: book.title)
  end
end