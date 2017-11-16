$(document).on("turbolinks:load", function(){
  $(".city_selection").change(function(){
    var city_id = $(this).val();
    load_data_for_select("districts", city_id, "id", ".district_selection", 
      "select_district");
  });

  $(".city_filter").change(function(){
    var city_key_name = $(this).val();
    load_data_for_select("districts", city_key_name, "key_name", ".district_filter", 
      "all_disticts");
  });

  $(".center_category_filter").change(function(){
    var center_category_key_name = $(this).val();
    load_data_for_select("categories", center_category_key_name, "key_name", 
      ".course_category_filter", "all_course_categories");
  });

  $(".course_category_filter").change(function(){
    var course_category_key_name = $(this).val();
    load_data_for_select("categories", course_category_key_name, "key_name", 
      ".course_sub_category_filter", "all_course_sub_categories")
  });

  $(".course_category_selection").change(function(){
    var course_category_id = $(this).val();
    load_data_for_select("categories", course_category_id, "id", 
      ".select2_course_sub_categories", "select_course_sub_categories");
  });
});

function load_data_for_select(model, findable_params, value_attribute, target_element, blank_option = ""){
  $.ajax({
    url: "/supports/" + model,
    type: "GET",
    dataType: "script",
    data: {
      findable_params: findable_params,
      value_attribute: value_attribute, 
      target_element: target_element,
      blank_option: blank_option
    }
  });
}
