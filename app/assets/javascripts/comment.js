$(document).ready(function() {
  $(this).on("click", ".btn-save-comment", function() {
    var comment_data = $(this).data();
    var url = "/comments/" + comment_data.comment;
    var content = $("#comment-" + comment_data.comment + " .edit-comment-content").val();
    $.ajax({
      url: url,
      method: "patch",
      data: {content: content},
      dataType: "script"
    });
  });

  $(document).on("click", ".btn-cancel-comment", function() {
    $(this).parent().prev(".comment-form").show();
    $(this).parent().html("");
  });
});
