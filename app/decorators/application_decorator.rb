class ApplicationDecorator < Draper::Decorator

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
