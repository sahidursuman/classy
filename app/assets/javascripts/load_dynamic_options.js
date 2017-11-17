$(document).on("turbolinks:load", function(){
  $(".city_selection").change(function(){
    var city_id = $(this).val();
    load_data_for_select("districts", city_id, "id", ".district_selection");
  });

  $(".city_filter").change(function(){
    var city_key_name = $(this).val();
    load_data_for_select("districts", city_key_name, "key_name", ".select2_districts");
  });

  $(".center_category_filter").change(function(){
    var center_category_key_name = $(this).val();
    load_data_for_select("categories", center_category_key_name, "key_name", ".course_category_filter");
  });

  $(".course_category_filter").change(function(){
    var course_category_key_name = $(this).val();
    load_data_for_select("categories", course_category_key_name, "key_name", ".select2_course_sub_categories")
  });

  $(".course_category_selection").change(function(){
    var course_category_id = $(this).val();
    load_data_for_select("categories", course_category_id, "id", ".select2_course_sub_categories");
  });
});

function load_data_for_select(model, findable_params, value_attribute, target_element){
  $.ajax({
    url: "/supports/" + model,
    type: "GET",
    dataType: "script",
    data: {
      findable_params: findable_params,
      value_attribute: value_attribute, 
      target_element: target_element
    }
  });
}
