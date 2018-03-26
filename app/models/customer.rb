class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :orders
  has_many :ratings

  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :shipping_address, class_name: 'Address', optional: true

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  def billing_address
    super() || build_billing_address
  end

  def shipping_address
    super() || build_shipping_address
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |customer|
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0,20]
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |customer|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        customer.email = data['email'] if customer.email.blank?
      end
    end
  end

  def soft_delete
    self.touch(:deleted_at)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end

end
