$(document).on("turbolinks:load", function(){
  $(".center_search_form").change(function(){
    $(this).trigger("submit.rails");
  })
});
