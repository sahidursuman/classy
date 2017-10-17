$(document).ready(function(){
  $(this).on("click", ".vote_review", function(){
    var vote_data = $(this).data();
    var url = "/reviews/" + vote_data.review + "/votes";
    var data, method;

    if ($(this).hasClass("voted")) {
      method = "delete"
    } else {
      data = {vote_type: vote_data.type}
      method = "post"
    }
    $.ajax({
      url: url,
      method: method,
      data: data,
      dataType: "script"
    });
  });
});
