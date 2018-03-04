class CreditCardDecorator < ApplicationDecorator
  def hidden_number
    object.number.chars.each_slice(4).map(&:join).join(' ')
  end
end