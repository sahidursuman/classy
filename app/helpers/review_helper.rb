module ReviewHelper
  def rating_values
    Settings.review.rating_values
  end

  def criterion_list
    Settings.review.criteria.map &:attr_name
  end

  def review_sorting_options
    Review::SORT_OPTIONS.map {|option| [t(".#{option}"), option]}
  end
end
