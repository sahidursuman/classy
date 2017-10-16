module ReviewHelper
  def rating_values
    Settings.review.rating_values
  end

  def criterion_list
    Settings.review.criteria.map &:attr_name
  end
end
