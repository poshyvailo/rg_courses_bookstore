class CreditCard < ApplicationRecord

  validates :card_owner, :number, :cvv, :expiration, presence: true

  def expiration=(date)
    write_attribute(:expiration, Date.strptime(date, "%m / %y"))
  end

  def number=(value)
    write_attribute(:number, value.tr(' ', ''))
  end

end
