class BookDecorator < ApplicationDecorator
  delegate_all

  def authors_list
    authors.map { |author| "#{author.firstname} #{author.lastname}" }.to_sentence
  end

  def dimension
    "H: #{width}\" x W: #{height}\" x D: #{depth}\""
  end

  def price_in_euro
    "€#{price}"
  end
end
