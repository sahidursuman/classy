$(document).on("turbolinks:load", function(){
  $(".city_selection").change(function(){
    var city_id = $(this).val();
    load_data_for_select(city_id, "districts");
  });

  $(".course_category_selection").change(function(){
    var course_category_id = $(this).val();
    load_data_for_select(course_category_id, "course_sub_categories");
  });
});

function load_data_for_select(selected_object, model){
  $.ajax({
    url: "/supports/" + model,
    type: "GET",
    dataType: "script",
    data: {object: selected_object}
  });
}
