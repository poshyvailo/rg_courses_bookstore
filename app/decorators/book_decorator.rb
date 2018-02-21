class BookDecorator < ApplicationDecorator
  delegate_all

  def authors_list
    authors.map { |author| "#{author.firstname} #{author.lastname}" }.to_sentence
  end

  def images

  end

  def reviews

  end

end
