$(document).on("turbolinks:load", function() {
  $('[data-toggle="tooltip"]').tooltip({
    trigger: 'hover'
  })

  $("#review-list").on("mouseenter mouseleave", ".comment", function(){
    $(this).find(".wrap-actions").toggleClass("active");
  });
});
