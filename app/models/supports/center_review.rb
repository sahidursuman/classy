class Supports::CenterReview
  attr_reader :center, :filter

  def initialize center, filter
    @center = center
    @filter = filter || {}
  end

  def reviewable
    @reviewable ||= center.branches.find_by(slug: filter[:branch_slug_eq]) || center
  end

  def avarage_rating_criteria
    @avarage_rating_criteria ||= reviewable.reviews.verified.avarage_rating
  end

  def branch_options
    @branch_options ||= center.branches.order_name_asc.includes(:city).group_by{|b| b.city}
      .sort_by{|k, v| k.priority}.reverse.map{|k, v| [k.name, v.pluck(:name, :slug)]}
  end

  def review_classification
    @classification ||= reviewable.reviews.verified.classification
  end
end
