class Supports::CenterSearch
  attr_reader :search_params, :page

  CENTER_SEARCH_ATTRIBUTES = [:city_key_name_eq, :district_key_name_eq,
    :center_category_key_name_eq]
  COURSE_SEARCH_ATTRIBUTES = [:course_category_key_name_eq, :course_sub_categories_key_name_eq]
  BRANCH_SEARCH_ATTRIBUTES = [:city_key_name_eq, :district_key_name_eq]

  def initialize search_params, page = nil
    @search_params = search_params
    @page = page
  end

  def centers
    @centers ||= ::Center.active.ransack_search_result(center_conditions).from("centers centers")
      .joins("INNER JOIN (#{course_search_sql}) course_search ON centers.id = course_search.center_id")
      .select("centers.*, course_search.min_price as min_course_price, course_search.count_course as count_course")
      .includes(:cities, branches: :district)
      .page(page).per(Settings.center_search.center_per_page).decorate
  end

  def course_results
    @course_results ||= Course.ransack_search_result(course_conditions.merge center_id_in: centers.pluck(:id))
  end

  def course_search_sql
    Course.ransack_search_result(course_conditions).min_price_on_center.to_sql
  end

  private
  def center_search_params
    @center_search_params ||= search_params.permit CENTER_SEARCH_ATTRIBUTES
  end

  def course_search_params
    @course_search_params ||= search_params.permit COURSE_SEARCH_ATTRIBUTES
  end

  def branch_search_params
    @branch_search_params ||= search_params.permit BRANCH_SEARCH_ATTRIBUTES
  end

  def center_conditions
    @center_conditions ||= if without_search_params? course_search_params
      center_search_params
    else
      center_search_params.except :center_category_key_name_eq
    end
  end

  def course_conditions
    @course_conditions ||= if course_search_params[:course_sub_categories_key_name_eq].present?
      course_search_params.except :course_category_key_name_eq
    else
      course_search_params
    end
  end

  def without_search_params? params
    params.values.all? &:blank?
  end
end
