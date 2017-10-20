$(document).ready(function() {
  $(this).on("click", ".comment-review", function() {
    var comment_data = $(this).data();
    var url = "/reviews/" + comment_data.review + "/comments";
    var content = $("#review-details-" + comment_data.review + " .new-comment-content").val();
    $.ajax({
      url: url,
      method: "post",
      data: {content: content},
      dataType: "script"
    });
  });
});
