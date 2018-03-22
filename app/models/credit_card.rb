class CreditCard < ApplicationRecord

  validates :card_owner, :number, :cvv, :expiration, presence: true

  validates :card_owner, format: { with: /\A[a-zA-Z\-\s]+\z/ }
  validates :number, :cvv, format: { with: /\A[0-9]+\z/ }

  validates :card_owner, length: { maximum: 50 }
  validates :number, length: { is: 16 }
  validates :cvv, length: { in: 3..4 }

  validate :expiration_not_be_in_the_past

  def expiration=(date)
      begin
        write_attribute(:expiration, Date.strptime(date, "%m / %y")) if date
      rescue ArgumentError
        nil
      end
  end

  def expiration_not_be_in_the_past
    if expiration.present? && expiration < Date.today
      errors.add(:expiration, "can't be in the past")
    end
  end
end
