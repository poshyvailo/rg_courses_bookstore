class CreditCard < ApplicationRecord

  validates :card_owner, :number, :cvv, :expiration, presence: true

  def expiration=(date)
      begin
        write_attribute(:expiration, Date.strptime(date, "%m / %y")) if date
      rescue ArgumentError
        nil
      end
  end
end
