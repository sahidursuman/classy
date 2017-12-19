$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip({
    trigger: 'hover'
  })

  $(".comment").hover(function() {
    $(this).find(".wrap-actions").toggleClass("active");
  })
});
