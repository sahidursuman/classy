$(document).on("turbolinks:load", function(){
  $(".center_sort_option").click(function(event){
    event.preventDefault();
    $(".center_sort_option").removeClass("active");
    $(this).addClass("active");
    $("#center_search_form_order_by").val($(this).data("value"));
    $("#center_search_form").trigger("submit.rails");
  });
});
