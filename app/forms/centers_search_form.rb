class CentersSearchForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :city_key_name_eq, :district_key_name_eq, :center_category_key_name_eq,
    :course_category_key_name_eq, :course_sub_category_key_name_eq

  SEARCHABLE_ATTRIBUTES = [:city_key_name_eq, :district_key_name_eq, :center_category_key_name_eq, 
    :course_category_key_name_eq, :course_sub_category_key_name_eq]
end
