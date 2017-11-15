class SearchCentersForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :city_key_name_eq, :districts_key_name_eq_any, :center_category_key_name_eq,
    :course_category_key_name_eq, :course_sub_category_key_name_eq, :city, :center_category,
    :course_category
end
