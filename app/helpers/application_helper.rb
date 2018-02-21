module ApplicationHelper
  def categories
    Category.all
  end

  def categories_with_count_books
    categories
  end
end
