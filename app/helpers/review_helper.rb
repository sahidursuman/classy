module ReviewHelper
  def rating_values
    Settings.review.rating_values
  end

  def criterion_list
    Settings.review.criteria.map &:attr_name
  end

  def review_level_list
    Settings.review.levels.map &:name
  end

  def review_sorting_options
    Review::SORT_OPTIONS.map {|option| [t(".#{option}"), option]}
  end

  def avarage_rating_format number
    if number.present?
      number_with_precision number, precision: Settings.review.summary_rating_precision
    else
      "--"
    end
  end

  def review_counter_format number
    (number.present? && number > 0) ? number : "--"
  end

  def rating_label number
    number.present? ? (number > Settings.review.avarage ? "high" : "low") : "none"
  end

  def rating_to_percentage rating
    number_to_percentage (rating.to_f/Settings.review.max_rating) * 100
  end
end
