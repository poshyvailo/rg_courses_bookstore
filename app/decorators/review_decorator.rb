class ReviewDecorator < ApplicationDecorator
  delegate_all

  def date
    created_at.strftime("%Y-%m-%d")
  end

  def logo_letter
    firstname.chars.first.capitalize
  end

  def fullname
    "#{firstname} #{lastname}"
  end

  def verified
    'Verified Reviewer' if object.verified
  end

end
