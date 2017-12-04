class CenterSearchForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :city_key_name_eq, :district_key_name_eq, :center_category_key_name_eq,
    :course_category_key_name_eq, :course_sub_categories_key_name_eq

  SEARCHABLE_ATTRIBUTES = [:city_key_name_eq, :district_key_name_eq, :center_category_key_name_eq,
    :course_category_key_name_eq, :course_sub_categories_key_name_eq]

  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true

  def search_by_district?
    district_key_name_eq.present?
  end

  def location_conditions
    {city_key_name_eq: city_key_name_eq, district_key_name_eq: district_key_name_eq}
  end

  def location
    [district_name, city_name].compact.join ", "
  end

  def city
    @city ||= if city_key_name_eq.present?
      City.friendly_find city_key_name_eq
    else
      City.first
    end
  end

  def district
    @district ||= if district_key_name_eq.present?
      city.districts.friendly_find district_key_name_eq
    end
  end

  def center_category
    @center_category ||= if center_category_key_name_eq.present?
      CenterCategory.friendly_find center_category_key_name_eq
    else
      CenterCategory.first
    end
  end

  def course_category
    @course_category ||= if course_category_key_name_eq.present?
      center_category.course_categories.friendly_find course_category_key_name_eq
    end
  end

  def city_options
    @city_options ||= City.priority_desc.pluck :name, :key_name
  end

  def center_category_options
    @center_category_options ||= CenterCategory.priority_desc.pluck :name, :key_name
  end

  def district_options
    @district_options ||= city.districts.priority_desc.pluck :name, :key_name
  end

  def course_category_options
    @course_category_options ||= center_category.course_categories.priority_desc
      .pluck :name, :key_name
  end

  def course_sub_category_options
    @course_sub_category_options ||= if course_category
      course_category.course_sub_categories.priority_desc.pluck :name, :key_name
    else
      []
    end
  end
end
