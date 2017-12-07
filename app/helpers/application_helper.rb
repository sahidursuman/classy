module ApplicationHelper
  def index_on_pagination counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def custom_simple_format text
    simple_format strip_tags text
  end

  def currency_format number
    number_with_delimiter(number) + " " + t("currency_unit")
  end

  def summary_rating_format number
    if number.present?
      number_with_precision number, precision: Settings.review.summary_rating_precision
    else
      "--"
    end
  end
end
