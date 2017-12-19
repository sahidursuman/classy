class CentersSearchUrlMakerService
  attr_reader :search_params
  
  def initialize search_params
    @search_params = search_params
  end

  def perform
    "/search/#{pretty_location_path}/#{category_key_name}"
  end

  private
  def pretty_location_path
    [search_params[:city_key_name_eq], search_params[:district_key_name_eq]].select(&:present?)
      .join("/")
  end

  def category_key_name
    search_params[:course_sub_categories_key_name_eq].presence ||
      search_params[:course_category_key_name_eq].presence ||
      search_params[:center_category_key_name_eq].presence
  end
end
