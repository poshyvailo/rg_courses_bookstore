class ApplicationDecorator < Draper::Decorator

  include ActionView::Helpers::TextHelper
  include ActionView::Context
  include ActionView::Helpers::UrlHelper

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
