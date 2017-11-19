class ParseUrlToSearchParamsService
  attr_reader :params, :search_params

  CATEGORY_SEARCH_PARAMS = [:center_category_key_name_eq, :course_category_key_name_eq, 
    :course_sub_categories_key_name_eq]

  def initialize params
    @params = params
  end

  def perform
    @search_params = Hash.new
    location_mapping
    category_mapping
    search_params
  end

  def location_mapping
    search_params[:city_key_name_eq] = params[:city_name].to_s
    search_params[:district_key_name_eq] = params[:district_name].to_s
  end

  def category_mapping
    return unless category = Category.find_by(key_name: params[:category_name])
    key_names = [category.key_name] 
    while category.parent_id.present? do
      category = category.parent_category
      key_names.unshift category.key_name
    end
    CATEGORY_SEARCH_PARAMS.each_with_index do |value, index|
      search_params[value] = key_names[index].to_s
    end
  end
end
