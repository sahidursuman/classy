$(document).on("turbolinks:load", function() {
  window.onscroll = function() {
    stick_navbar()
  };

  var sticky = $("#sticked-navbar")[0].offsetTop;

  function stick_navbar() {
    if (window.pageYOffset >= sticky) {
      $("#sticked-navbar").addClass("sticked");
      $("#content-container").addClass("sticked-body")
    } else {
      $("#sticked-navbar").removeClass("sticked");
      $("#content-container").removeClass("sticked-body")
    }
  }
})
