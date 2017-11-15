class Supports::SearchCenters
  attr_reader :search_form

  def initialize search_form
    @search_form = search_form
  end

  def city 
    @city ||= if search_form.city_key_name_eq.present?
      City.find_by key_name: search_form.city_key_name_eq 
    end
  end

  def center_category
    @center_category ||= if search_form.center_category_key_name_eq.present?
      CenterCategory.find_by key_name: search_form.center_category_key_name_eq
    end
  end

  def course_category
    @course_category ||= if center_category.present? && search_form.course_category_key_name_eq.present?
      center_category.course_categories.find_by key_name: search_form.course_category_key_name_eq
    end
  end

  def city_options 
    @city_options ||= City.pluck :name, :key_name
  end

  def center_category_options 
    @center_category_options ||= CenterCategory.pluck :name, :key_name
  end

  def district_options
    @district_options ||= if city
      city.districts.pluck :name, :key_name
    else
      []
    end
  end

  def course_category_options 
    @course_category_options ||= if center_category
      center_category.course_categories.pluck :name, :key_name
    else
      []
    end
  end

  def course_sub_category_options
    @course_sub_category_options ||= if course_category
      course_category.course_sub_categories.pluck :name, :key_name
    else
      []
    end
  end
end
