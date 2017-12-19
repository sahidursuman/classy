module ApplicationHelper
  def index_on_pagination counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def custom_simple_format text, options = {}
    simple_format strip_tags(text), {}, options
  end

  def currency_format number
    number_with_delimiter(number) + t("currency_unit")
  end

  def time_as_format time, format = :default
    l time, format: format
  end
end
