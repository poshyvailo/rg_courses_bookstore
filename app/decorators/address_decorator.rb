class AddressDecorator < ApplicationDecorator
  delegate_all

  def fullname
    "#{firstname} #{lastname}"
  end

  def country_name
    c = ISO3166::Country[object.country]
    c.translations[I18n.locale.to_s] || c.name
  end

end