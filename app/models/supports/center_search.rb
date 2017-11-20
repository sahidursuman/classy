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
    @centers ||= ::Center.active.ransack_search_result(center_conditions).page(page)
      .per Settings.center_search.center_per_page
  end

  def results
    centers.map do |center|
      {center: center, branches: match_branch(center)}
    end
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
      center_search_params.merge id_in: ids_center_has_courses
    end
  end

  def course_conditions
    @course_conditions ||= if course_search_params[:course_sub_categories_key_name_eq].present? 
      course_search_params.except :course_category_key_name_eq
    else
      course_search_params
    end
  end

  def ids_center_has_courses
    @ids_center_has_courses ||= Course.ransack_search_result(course_conditions)
      .pluck(:center_id).uniq
  end

  def branch_results
    @branch_results ||= Branch.active.ransack_search_result(branch_search_params
      .merge center_id_in: centers.pluck(:id)).includes :center, :city, :district
  end

  def match_branch center
    branch_results.select do |branch|
      branch.center_id == center.id
    end
  end

  def without_search_params? params
    params.values.all? &:blank?
  end
end
