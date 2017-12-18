$(document).on("turbolinks:load", function() {
  $("#notification_header").on("click", function(){
    $.ajax({
      url: "/my_page/notifications",
      type: "GET",
      dataType: "script"
    });
  });
});
