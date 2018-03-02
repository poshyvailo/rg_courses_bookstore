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

  def short_description
    truncate(description, length: 500, separator: ' ', omission: '... ') { link_to "View More", "#" }
   end

  def very_short_description
    truncate(description, length: 100, separator: ' ')
  end

  def images

  end

  def reviews

  end
end
