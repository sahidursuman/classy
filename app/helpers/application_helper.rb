module ApplicationHelper
  def index_on_pagination counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def custom_simple_format text
    simple_format strip_tags text
  end
end
