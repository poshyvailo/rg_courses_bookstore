class CreditCardDecorator < ApplicationDecorator
  delegate_all

  def hidden_number
    "#{'**** ' * 3} #{number[-4..-1]}"
  end

  def input_exp
    expiration.strftime("%m / %y") if expiration
  end

  def show_exp
    expiration.strftime("%m/%Y") if expiration
  end
end